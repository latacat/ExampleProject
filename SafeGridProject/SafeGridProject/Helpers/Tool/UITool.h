//
//  UITool.h
//  BeijingOpenUniversity
//
//  Created by leizi on 2018/11/23.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITool : NSObject

+(UILabel *)labelWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)color  isleft:(BOOL)ret;

+ (UIButton *)ButtonWithFrame:(CGRect)frame
                             Target:(id)target
                             Action:(SEL)action
                              Title:(NSString *)title
                         titleColor:(UIColor *)titleColor
                          backColor:(UIColor *)bgColor
                       cornerRadius:(CGFloat)cornerRadius
                              masks:(BOOL)YESorNO;

+ (UIView *)ViewWithFrame:(CGRect)frame
                  bgColor:(UIColor *)bgColor
             cornerRadius:(CGFloat)cornerRadius
                    masks:(BOOL)YESorNO;


+ (UITextField *)TextFieldWithFrame:(CGRect)frame
                              placeholder:(NSString *)placeholder
                                 password:(BOOL)YESorNO
                            leftImageView:(UIImageView *)leftImageView
                           rightImageView:(UIImageView *)rightImageView
                                     Font:(float)font;

+ (UIImageView *)ImageViewWithFrame:(CGRect)frame ImageName:(NSString *)imageName;


+(CGFloat)getTextHeightWithStr:(NSString *)str
                     withWidth:(CGFloat)width
               withLineSpacing:(CGFloat)lineSpacing
                      withFont:(CGFloat)font;


#pragma mark - 获取当前时间的 时间戳

+(NSInteger)getNowTimestamp;


#pragma mark - 将某个时间转化成 时间戳

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

#pragma mark - 将某个时间戳转化成 时间

+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

#pragma mark 字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

#pragma mark 字典转字符串;
+(NSString *)convertToJsonData:(NSDictionary *)dict;


#pragma mark 根据文本获取labelSize;
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width;

#pragma mark 转换文件大小为K,M.GB
+ (NSString *)convertSize:(long long)length;

#pragma mark 创建文件夹
+(BOOL)createDirectoryAtPath:(NSString *)path error:(NSError *__autoreleasing *)error ;

@end

NS_ASSUME_NONNULL_END
