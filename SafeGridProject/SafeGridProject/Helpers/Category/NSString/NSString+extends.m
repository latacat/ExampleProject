//
//  NSString+extends.m
//  ZhongDa
//
//  Created by Mac on 15/12/1.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+extends.h"

#import <CommonCrypto/CommonDigest.h>

#define PASS @"zoeopvnm3sab"

@implementation NSString (extends)

+ (NSString *)dateStringWithMD5
{
    NSDate *datenow = [NSDate date]; //现在时间
    
    NSTimeZone *standardTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
    [dateFormatter setTimeZone:standardTimeZone];
    
    NSString *timeStringWithEncryptionKey = [NSString stringWithFormat:@"%@%@", PASS, [dateFormatter stringFromDate:datenow]];
    
    return [self encryptByMD5WithString:timeStringWithEncryptionKey];
}

+ (NSString *)userTokenWithMD5
{
    NSDate *datenow =[NSDate date]; //现在时间
    
    NSTimeZone *standardTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
    [dateFormatter setTimeZone:standardTimeZone];
    
    NSString *userToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserToken"];
    NSLog(@"token - > %@", userToken);
    
    NSString *timeStringWithEncryptionKey = [NSString stringWithFormat:@"%@%@", userToken, [dateFormatter stringFromDate:datenow]];
    
    return [self encryptByMD5WithString:timeStringWithEncryptionKey];
}

+ (NSString *)encryptByMD5WithString:(NSString *)encryptString{

    const char *cStr = [encryptString UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result); // This is the md5 call
    NSString *md5 = [NSString stringWithFormat:
                     @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                     result[0], result[1], result[2], result[3],
                     result[4], result[5], result[6], result[7],
                     result[8], result[9], result[10], result[11],
                     result[12], result[13], result[14], result[15]
                     ];
    
    return md5;
}

+ (NSTimeInterval)dateStringWithTimestamp{

    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    return [dat timeIntervalSince1970];
}

+ (NSString *)exchangeTimestamp:(NSTimeInterval)timeStamp withFormat:(NSString *)format{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:format];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [df stringFromDate:date];
}

- (NSString *)timestamp{
    
    NSArray *conponents = [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]];
    NSRange range = {0 ,10};
    
    return [conponents[1] substringWithRange:range];
}

- (NSString *)exchangeTimestamp{

    NSArray *conponents = [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]];
    
    NSRange range = {0 ,10};
    NSString *timeStamp = [conponents[1] substringWithRange:range];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM月dd日"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]];
    return [df stringFromDate:date];
}

- (NSString *)exchangeTimestampWithFormat:(NSString *)format{
    
    NSArray *conponents = [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]];
    
    NSRange range = {0 ,10};
    NSString *timeStamp = [conponents[1] substringWithRange:range];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:format];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]];
    return [df stringFromDate:date];
}

+ (NSString *)dateStringWithFormat{
    
    NSDate *datenow = [NSDate date]; //现在时间
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [df stringFromDate:datenow];
}

- (NSString *)exchangeString:(NSString *)exchangeString toString:(NSString *)newString{
    
    return [self stringByReplacingOccurrencesOfString:exchangeString withString:newString];
//    NSArray *array = [self componentsSeparatedByString:exchangeString];
//    return [array componentsJoinedByString:newString];
}

- (NSString *)transformToTaobaoLink{
    
    NSString *noHTTPString = [self stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    NSString *noHTTPsString = [noHTTPString stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    
    NSString *urlStr = [NSString stringWithFormat:@"taobao://%@", noHTTPsString];
    
    return urlStr;
}

- (NSString *)exchangeHTMLStringToString{
    
    // 实现HTML解析成String
    NSString * str = [[[NSAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil] string];
    
    return [[[[str exchangeString:@"</ br>" toString:@""] exchangeString:@"&nbsp;" toString:@" "]exchangeString:@"nbsp;" toString:@""] exchangeString:@"<br />" toString:@""];
}
- (NSString *)trim{
    
    NSString *cleanString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return cleanString;
}

- (BOOL)isPhoneNumber{
    
    //电信号段:133/153/180/181/189/177
    //联通号段:130/131/132/155/156/185/186/145/176
    //移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //虚拟运营商:170
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:self];
}

- (void)enumerateStringsMatchedByRegex:(NSString *)regularStr changeStr:(NSString *)changeStr usingBlock:(void(^)(NSArray *matches,NSRange range,NSString *matchStr))usingBlock{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularStr options:0 error:nil];
    
    
    NSArray *matches = [regex matchesInString:changeStr options:0 range:NSMakeRange(0,changeStr.length)];
    
    
    for(NSTextCheckingResult *result in [matches objectEnumerator]) {
        
        //          NSRange Range = [result range];
        
        NSString *clis = [changeStr substringWithRange:result.range];
        //        NSLog(@"%@",clis);
        usingBlock(matches,result.range,clis);
    }
    
}

@end
