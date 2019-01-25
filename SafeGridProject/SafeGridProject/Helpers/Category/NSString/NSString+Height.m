//
//  NSString+Height.m
//  JingHuaTimes
//
//  Created by 周永超 on 2017/5/11.
//  Copyright © 2017年 zhouyongchao. All rights reserved.
//

#import "NSString+Height.h"

@implementation NSString (Height)

- (CGFloat)zyc_widthForFont:(UIFont *)font {
    CGSize size = [self zyc_sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)zyc_heightForFont:(UIFont *)font
                       width:(CGFloat)width {
    CGSize size = [self zyc_sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (CGSize)zyc_sizeForFont:(UIFont *)font
                     size:(CGSize)size
                     mode:(NSLineBreakMode)lineBreakMode {
    
    CGSize result;
    
    if (!font) {
        font = [UIFont systemFontOfSize:14];
    }
    
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        NSMutableDictionary *styleDict = [NSMutableDictionary dictionary];
        styleDict[NSFontAttributeName] = font;
        
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle.lineBreakMode = lineBreakMode;
            paragraphStyle.lineSpacing = 5.f;
            styleDict[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        
        CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:styleDict context:nil];
        
        result = rect.size;
        
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
        
#pragma clang diagnostic pop
    }
    return result;
    
}




@end
