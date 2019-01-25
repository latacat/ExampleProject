//
//  UITool.m
//  BeijingOpenUniversity
//
//  Created by leizi on 2018/11/23.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import "UITool.h"

@implementation UITool
+(UILabel *)labelWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)color  isleft:(BOOL)ret{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = font;
    label.textColor = color;
    if (ret == YES) {
        label.textAlignment = NSTextAlignmentLeft;
    }else{
        label.textAlignment = NSTextAlignmentRight;
    }
    return label;
}



+ (UIButton *)ButtonWithFrame:(CGRect)frame
                             Target:(id)target
                             Action:(SEL)action
                              Title:(NSString *)title
                         titleColor:(UIColor *)titleColor
                          backColor:(UIColor *)bgColor
                       cornerRadius:(CGFloat)cornerRadius
                              masks:(BOOL)YESorNO{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:bgColor];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.layer.masksToBounds = YESorNO;
    button.layer.cornerRadius = cornerRadius;
    
    return button;
}

+ (UIView *)ViewWithFrame:(CGRect)frame
                  bgColor:(UIColor *)bgColor
             cornerRadius:(CGFloat)cornerRadius
                    masks:(BOOL)YESorNO{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = bgColor;
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YESorNO;
    return view;
}

+ (UIImageView *)ImageViewWithFrame:(CGRect)frame ImageName:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    
    [imageView setImage:[UIImage imageNamed:imageName]];
    [imageView setUserInteractionEnabled:YES];
    
    return imageView;
}

+ (UITextField *)TextFieldWithFrame:(CGRect)frame
                              placeholder:(NSString *)placeholder
                                 password:(BOOL)YESorNO
                            leftImageView:(UIImageView *)leftImageView
                           rightImageView:(UIImageView *)rightImageView
                                     Font:(float)font {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    
    [textField setPlaceholder:placeholder];
    [textField setTextAlignment:NSTextAlignmentLeft];
    [textField setSecureTextEntry:YESorNO];
    [textField setKeyboardType:UIKeyboardTypeEmailAddress];
    [textField setAutocapitalizationType:NO];
    [textField setClearButtonMode:YES];
    [textField setLeftView:leftImageView];
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    [textField setRightView:rightImageView];
    [textField setRightViewMode:UITextFieldViewModeWhileEditing];
    [textField setFont:[UIFont systemFontOfSize:font]];
    [textField setTextColor:[UIColor blackColor]];
    
    return textField;
}

/**
 计算文本高度
 
 @param str         文本内容
 @param width       lab宽度
 @param lineSpacing 行间距(没有行间距就传0)
 @param font        文本字体大小
 
 @return 文本高度
 */
+(CGFloat)getTextHeightWithStr:(NSString *)str
                     withWidth:(CGFloat)width
               withLineSpacing:(CGFloat)lineSpacing
                      withFont:(CGFloat)font
{
    
    if (!str || str.length == 0) {
        return 0;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing =  lineSpacing;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attStr);
    CGSize attSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0), NULL,CGSizeMake(width, CGFLOAT_MAX), NULL);
    CFRelease(frameSetter);
    
    return attSize.height;
    
}




#pragma mark - 获取当前时间的 时间戳

+(NSInteger)getNowTimestamp{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间
    
    
    
    NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    
    //时间转时间戳的方法:
    
    
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    
    
    
    NSLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值
    
    
    
    return timeSp;
    
}



//将某个时间转化成 时间戳

#pragma mark - 将某个时间转化成 时间戳

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    
    
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    
    
    
    return timeSp;
    
}



//将某个时间戳转化成 时间

#pragma mark - 将某个时间戳转化成 时间
//format:YYYY-MM-dd hh:mm:ss
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSTimeInterval interval    =timestamp/ 1000.0;

    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:interval];
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    
    
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    
    
    
    return confromTimespStr;
    
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

// 字典转json字符串方法

+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
/// 根据指定文本,字体和最大宽度计算尺寸
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}

+ (NSString *)convertSize:(long long)length {
    if(length<1024) {
        return [NSString stringWithFormat:@"%lldB",length];
    }else if(length>=1024&&length<1024*1024) {
        return [NSString stringWithFormat:@"%.0fK",(float)length/1024];
    }else if(length >=1024*1024&&length<1024*1024*1024) {
        return [NSString stringWithFormat:@"%.1fM",(float)length/(1024*1024)];
    }else {
        return [NSString stringWithFormat:@"%.1fG",(float)length/(1024*1024*1024)];
    }
    
}

+(BOOL)createDirectoryAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    NSFileManager *manager = [NSFileManager defaultManager];
    /* createDirectoryAtPath:withIntermediateDirectories:attributes:error:
     * 参数1：创建的文件夹的路径
     * 参数2：是否创建媒介的布尔值，一般为YES
     * 参数3: 属性，没有就置为nil
     * 参数4: 错误信息
     */
    BOOL isSuccess = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
    return isSuccess;
}

@end
