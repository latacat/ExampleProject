
//
//  CommonTools.m
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/31.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "CommonTools.h"

@implementation CommonTools

+ (CommonTools *)shareInstance {
    static dispatch_once_t onceToken;
    static CommonTools *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[CommonTools alloc]init];
    });
    return instance;
}

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9],199
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678]|99)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56]|98)\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700,191
     */
    NSString *CT = @"(^1(33|53|66|77|8[019]|91)\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)isLegalPassword:(NSString *)password {
    if (password.length < 6 || password.length > 16) {
        return NO;
    }
    
    NSString *regex = @"^(?=.*[0-9])(?=.*[a-z]|[A-Z]).{6,16}$";
    NSPredicate *regexPassword = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([regexPassword evaluateWithObject:password] == YES) {
        return YES;
    } else {
        return NO;
    }
    return NO;
}

@end
