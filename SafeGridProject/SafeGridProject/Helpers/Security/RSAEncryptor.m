//
//  RSAEncryptor.m
//  MovieCircle
//
//  Created by zhouyongchao on 15/12/23.
//  Copyright (c) 2015年 dzy. All rights reserved.
//

#import <Security/Security.h>
#import "RSAEncryptor.h"
#import <CommonCrypto/CommonCrypto.h>
#import "Base64.h"

@implementation RSAEncryptor
{
    SecKeyRef publicKey;
    
    SecKeyRef privateKey;
}


-(void)dealloc
{
    if (nil != publicKey) {
        CFRelease(publicKey);
    }
    if (nil != privateKey) {
        CFRelease(privateKey);
    }
}



-(SecKeyRef) getPublicKey {
    return publicKey;
}

-(SecKeyRef) getPrivateKey {
    return privateKey;
}



-(void) loadPublicKeyFromFile: (NSString*) derFilePath
{
    NSData *derData = [[NSData alloc] initWithContentsOfFile:derFilePath];
    [self loadPublicKeyFromData: derData];
}
-(void) loadPublicKeyFromData: (NSData*) derData
{
    publicKey = [self getPublicKeyRefrenceFromeData: derData];
}

-(void) loadPrivateKeyFromFile: (NSString*) p12FilePath password:(NSString*)p12Password
{
    NSData *p12Data = [NSData dataWithContentsOfFile:p12FilePath];
    [self loadPrivateKeyFromData: p12Data password:p12Password];
}

-(void) loadPrivateKeyFromData: (NSData*) p12Data password:(NSString*)p12Password
{
    privateKey = [self getPrivateKeyRefrenceFromData: p12Data password: p12Password];
}




#pragma mark - Private Methods

-(SecKeyRef) getPublicKeyRefrenceFromeData: (NSData*)derData
{
    SecCertificateRef myCertificate = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)derData);
    SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
    SecTrustRef myTrust;
    OSStatus status = SecTrustCreateWithCertificates(myCertificate,myPolicy,&myTrust);
    SecTrustResultType trustResult;
    if (status == noErr) {
        status = SecTrustEvaluate(myTrust, &trustResult);
    }
    SecKeyRef securityKey = SecTrustCopyPublicKey(myTrust);
    CFRelease(myCertificate);
    CFRelease(myPolicy);
    CFRelease(myTrust);
    
    return securityKey;
}


-(SecKeyRef) getPrivateKeyRefrenceFromData: (NSData*)p12Data password:(NSString*)password
{
    SecKeyRef privateKeyRef = NULL;
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init];
    [options setObject: password forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((__bridge CFDataRef) p12Data, (__bridge CFDictionaryRef)options, &items);
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
        securityError = SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
        if (securityError != noErr) {
            privateKeyRef = NULL;
        }
    }
    CFRelease(items);
    
    return privateKeyRef;
}



#pragma mark - 公钥加密

-(NSString*) rsaEncryptString:(NSString*)string {
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData* encryptedData = [self rsaEncryptData: data];
    NSString* base64EncryptedString = [encryptedData base64EncodedString];
    return base64EncryptedString;
}

// 加密的大小受限于SecKeyEncrypt函数，SecKeyEncrypt要求明文和密钥的长度一致，如果要加密更长的内容，需要把内容按密钥长度分成多份，然后多次调用SecKeyEncrypt来实现
-(NSData*) rsaEncryptData:(NSData*)data {
    SecKeyRef key = [self getPublicKey];
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    size_t blockSize = cipherBufferSize - 11;       // 分段加密
    size_t blockCount = (size_t)ceil([data length] / (double)blockSize);
    NSMutableData *encryptedData = [[NSMutableData alloc] init] ;
    for (int i=0; i<blockCount; i++) {
        int bufferSize = MIN((int)blockSize,(int)([data length] - i * blockSize));
        NSData *buffer = [data subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(key, kSecPaddingPKCS1, (const uint8_t *)[buffer bytes], [buffer length], cipherBuffer, &cipherBufferSize);
        if (status == noErr){
            NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
        }else{
            if (cipherBuffer) {
                free(cipherBuffer);
            }
            return nil;
        }
    }
    if (cipherBuffer){
        free(cipherBuffer);
    }
    return encryptedData;
}

#pragma mark - 私钥加密

- (NSString *)rsaPrivateKeyEncryptString:(NSString *)string {
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData* encryptedData = [self rsaPriavteKeyEncryptData: data];
    NSString* base64EncryptedString = [encryptedData base64EncodedString];
    return base64EncryptedString;
}

- (NSData *)rsaPriavteKeyEncryptData:(NSData *)data {
    SecKeyRef key = [self getPrivateKey];
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(key) * sizeof(uint8_t);
    void *outbuf = malloc(block_size);
    size_t src_block_size = block_size - 11;
    
    NSMutableData *ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyRawSign(key,
                               kSecPaddingPKCS1,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            ret = nil;
            break;
        }else{
            [ret appendBytes:outbuf length:outlen];
        }
    }
    
    free(outbuf);
    return ret;
}

#pragma mark - 私钥解密

-(NSString*) rsaDecryptString:(NSString*)string {
    
    NSData* data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData* decryptData = [self rsaDecryptData: data];
    NSString* result = [[NSString alloc] initWithData: decryptData encoding:NSUTF8StringEncoding];
    return result;
}

-(NSData*) rsaDecryptData:(NSData*)data {
    SecKeyRef key = [self getPrivateKey];
    size_t cipherLen = [data length];
    void *cipher = malloc(cipherLen);
    [data getBytes:cipher length:cipherLen];
    size_t plainLen = SecKeyGetBlockSize(key) - 12;
    void *plain = malloc(plainLen);
    OSStatus status = SecKeyDecrypt(key, kSecPaddingPKCS1, cipher, cipherLen, plain, &plainLen);
    
    if (status != noErr) {
        return nil;
    }
    
    NSData *decryptedData = [[NSData alloc] initWithBytes:(const void *)plain length:plainLen];
    
    return decryptedData;
}

#pragma mark - 公钥解密

- (NSString *)rsaPublicKeyDecrypt:(NSString *)string {
    NSData* data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData* decryptData = [self rsaPublicKeyDecryptData: data];
    NSString* result = [[NSString alloc] initWithData: decryptData encoding:NSUTF8StringEncoding];
    return result;
}

- (NSData*)rsaPublicKeyDecryptData:(NSData*)cipherData {
    SecKeyRef publicKeyRef = [self getPublicKey];
    size_t keySize = SecKeyGetBlockSize(publicKeyRef) * sizeof(uint8_t);
    double totalLength = [cipherData length];
    size_t blockSize = keySize;
    int blockCount = ceil(totalLength / blockSize);
    NSMutableData * plainData = [NSMutableData data];
    for (int i = 0; i < blockCount; i++) {
        NSUInteger loc = i * blockSize;
        long dataSegmentRealSize = MIN(blockSize, totalLength - loc);
        NSData * dataSegment = [cipherData subdataWithRange:NSMakeRange(loc, dataSegmentRealSize)];
        unsigned char * plainBuffer = malloc(keySize);
        memset(plainBuffer, 0, keySize);
        OSStatus status = noErr;
        size_t plainBufferSize ;
        status = SecKeyDecrypt(publicKeyRef,
                               kSecPaddingNone, // 解密的时候一定要用 无填充模式，拿到所有的数据自行解析
                               [dataSegment bytes],
                               dataSegmentRealSize,
                               plainBuffer,
                               &plainBufferSize
                               );
        if(status != noErr){
            free(plainBuffer);
            return nil;
        }
        
        NSData * data = [[NSData alloc] initWithBytes:plainBuffer length:plainBufferSize];
        
        NSData * startData = [data subdataWithRange:NSMakeRange(0, 1)];
        // 开头应该是 0001 但是原生解出来之后把开头的 00 忽略了
        if ([[startData description] isEqualToString:@"<01>"]) {
            Byte flag[] = {0x00};
            NSRange startRange = [data rangeOfData:[NSData dataWithBytes:flag length:1] options:NSDataSearchBackwards range:NSMakeRange(0, data.length)];
            NSUInteger s = startRange.location + startRange.length;
            if (startRange.location != NSNotFound && s < data.length) {
                data = [data subdataWithRange:NSMakeRange(s, data.length - s)];
            }
        }
        
        [plainData appendData:data];
        free(plainBuffer);
    }
    
    return plainData;
}

#pragma marke - verify file SHA1
-(BOOL) rsaSHA1VerifyData:(NSData *) plainData
            withSignature:(NSData *) signature {
    
    size_t signedHashBytesSize = SecKeyGetBlockSize([self getPublicKey]);
    const void* signedHashBytes = [signature bytes];
    
    size_t hashBytesSize = CC_SHA1_DIGEST_LENGTH;
    uint8_t* hashBytes = malloc(hashBytesSize);
    if (!CC_SHA1([plainData bytes], (CC_LONG)[plainData length], hashBytes)) {
        return NO;
    }
    
    OSStatus status = SecKeyRawVerify(publicKey,
                                      kSecPaddingPKCS1SHA1,
                                      hashBytes,
                                      hashBytesSize,
                                      signedHashBytes,
                                      signedHashBytesSize);
    
    return status == errSecSuccess;
}

#pragma mark - Class Methods

static RSAEncryptor* sharedInstance = nil;

+(void) setSharedInstance: (RSAEncryptor*)instance
{
    sharedInstance = instance;
}

+(RSAEncryptor*) sharedInstance
{
    return sharedInstance;
}
@end
