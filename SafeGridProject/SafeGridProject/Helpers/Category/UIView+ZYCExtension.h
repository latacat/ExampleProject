//
//  UIView+ZYCExtension.h
//  BeijingOpenUniversity
//
//  Created by 周永超 on 2018/12/17.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYCExtension)

@property (nonatomic, assign) IBInspectable CGFloat zycCornerRadius;

@property (nonatomic, assign) IBInspectable CGFloat zycBorderWidth;

@property (nonatomic, nullable, strong) IBInspectable UIColor *zycBorderColor;

@end

