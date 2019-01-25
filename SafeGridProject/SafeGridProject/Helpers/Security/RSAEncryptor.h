//
//  RSAEncryptor.h
//  MovieCircle
//
//  Created by zhouyongchao on 15/12/23.
//  Copyright (c) 2015年 dzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAEncryptor : NSObject



#pragma mark - Instance Methods

-(void) loadPublicKeyFromFile: (NSString*) derFilePath;
-(void) loadPublicKeyFromData: (NSData*) derData;

-(void) loadPrivateKeyFromFile: (NSString*) p12FilePath password:(NSString*)p12Password;
-(void) loadPrivateKeyFromData: (NSData*) p12Data password:(NSString*)p12Password;



//公钥加密
-(NSString*) rsaEncryptString:(NSString*)string;
-(NSData*) rsaEncryptData:(NSData*)data ;
//私钥加密
- (NSString *)rsaPrivateKeyEncryptString:(NSString *)string;
//私钥解密
-(NSString*) rsaDecryptString:(NSString*)string;
-(NSData*) rsaDecryptData:(NSData*)data;
//公钥加密
- (NSString *)rsaPublicKeyDecrypt:(NSString *)string;

-(BOOL) rsaSHA1VerifyData:(NSData *) plainData
            withSignature:(NSData *) signature;



#pragma mark - Class Methods

+(void) setSharedInstance: (RSAEncryptor*)instance;
+(RSAEncryptor*) sharedInstance;

@end
