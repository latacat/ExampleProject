//
//  NSString+extends.h
//  ZhongDa
//
//  Created by Mac on 15/12/1.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (extends)

+ (NSString *)dateStringWithMD5;
+ (NSString *)userTokenWithMD5;
+ (NSTimeInterval)dateStringWithTimestamp;      // 返回当前时间戳

// 根据给定的format和时间戳返回数据格式
+ (NSString *)exchangeTimestamp:(NSTimeInterval)timeStamp withFormat:(NSString *)format;
+ (NSString *)dateStringWithFormat;

- (NSString *)timestamp;
- (NSString *)exchangeTimestamp;
- (NSString *)exchangeTimestampWithFormat:(NSString *)format;

// 使用字符串替换制定字符串
- (NSString *)exchangeString:(NSString *)exchangeString toString:(NSString *)newString;
- (NSString *)transformToTaobaoLink;

- (NSString *)exchangeHTMLStringToString;
- (NSString *)trim;

- (BOOL)isPhoneNumber;

/*通过正则遍历所有匹配规则的字符串
 regularStr：正则文字
 changeStr：字符串
 usingBlock：结果
 */
- (void)enumerateStringsMatchedByRegex:(NSString *)regularStr changeStr:(NSString *)changeStr usingBlock:(void(^)(NSArray *matches,NSRange range,NSString *matchStr))usingBlock;

@end
