//
//  NSString+AES.h
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/29.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)

+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key;
+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key;

@end
