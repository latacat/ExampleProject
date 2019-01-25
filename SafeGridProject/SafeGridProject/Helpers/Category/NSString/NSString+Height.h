//
//  NSString+Height.h
//  JingHuaTimes
//
//  Created by 周永超 on 2017/5/11.
//  Copyright © 2017年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Height)

- (CGFloat)zyc_widthForFont:(UIFont *)font;
- (CGFloat)zyc_heightForFont:(UIFont *)font
                       width:(CGFloat)width;

@end
