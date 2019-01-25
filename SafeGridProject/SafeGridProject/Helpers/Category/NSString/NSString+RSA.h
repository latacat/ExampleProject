//
//  NSString+RSA.h
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/2/27.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RSA)

/**
 公钥加密

 @param plainText 加密字符串
 @return 加密结果
 */
+ (NSString *)rsaPublicKeyEncrypt:(NSString *)plainText;

/**
 公钥解密

 @param plainText 解密字符串
 @return 解密结果
 */
+ (NSString *)rsaPublicKeyDecrypt:(NSString *)plainText;

/**
 私钥解密

 @param encryptText 解密字符串
 @return 解密结果
 */
+ (NSString *)rsaPrivateKeyDectypt:(NSString *)encryptText;

/**
 私钥加密

 @param plainText 加密字符串
 @return 加密字符
 */
+ (NSString *)rsaPrivateKeyEncrypt:(NSString *)plainText;

@end
