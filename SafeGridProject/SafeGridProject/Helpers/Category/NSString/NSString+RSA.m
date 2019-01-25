//
//  NSString+RSA.m
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/2/27.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "NSString+RSA.h"
#import "RSAEncryptor.h"

@implementation NSString (RSA)
//公钥加密
+ (NSString *)rsaPublicKeyEncrypt:(NSString *)plainText
{
    RSAEncryptor *rsa = [[RSAEncryptor alloc] init];
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    [rsa loadPublicKeyFromFile:publicKeyPath];
    NSString *encryptedString = [rsa rsaEncryptString:plainText];
    return encryptedString;
}
//私钥解密
+ (NSString *)rsaPrivateKeyDectypt:(NSString *)encryptText
{
    RSAEncryptor *rsa = [[RSAEncryptor alloc] init];
    [rsa loadPrivateKeyFromFile:[[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"] password:@""];
    NSString *decryptedString = [rsa rsaDecryptString:encryptText];
    return decryptedString;
}
//私钥加密
+ (NSString *)rsaPrivateKeyEncrypt:(NSString *)plainText {
    
    RSAEncryptor *rsa = [[RSAEncryptor alloc] init];
    [rsa loadPrivateKeyFromFile:[[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"] password:@""];
    NSString *encryptedString = [rsa rsaPrivateKeyEncryptString:plainText];
    return encryptedString;
}
//公钥解密
+ (NSString *)rsaPublicKeyDecrypt:(NSString *)plainText {
    
    RSAEncryptor *rsa = [[RSAEncryptor alloc]init];
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    [rsa loadPublicKeyFromFile:publicKeyPath];
    NSString *decStr = [rsa rsaPublicKeyDecrypt:plainText];
    return decStr;
}

@end
