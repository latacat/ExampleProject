//
//  UIView+ZYCExtension.m
//  BeijingOpenUniversity
//
//  Created by 周永超 on 2018/12/17.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import "UIView+ZYCExtension.h"
#import <objc/runtime.h>

@implementation UIView (ZYCExtension)

- (CGFloat)zycCornerRadius {
    
    return self.layer.cornerRadius;
}

- (void)setZycCornerRadius:(CGFloat)zycCornerRadius {
    self.layer.cornerRadius = zycCornerRadius;
}

- (UIColor *)zycBorderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setZycBorderColor:(UIColor *)zycBorderColor {
    self.layer.borderColor = zycBorderColor.CGColor;
}

- (CGFloat)zycBorderWidth {
    return self.layer.borderWidth;
}

- (void)setZycBorderWidth:(CGFloat)zycBorderWidth {
    self.layer.borderWidth = zycBorderWidth;
}

@end
