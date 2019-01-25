//
//  UIView+Indicator.m
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/29.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "UIView+Indicator.h"

#define hudViewTag                     0x98751235

@implementation UIView (Indicator)

- (void)showTextMsgAtCenter:(NSString *)message {
    
    if ([message isEqualToString:@""] || message == nil) {
        return;
    }
    MBProgressHUD *hud = [self HUDAtCurrentView];
    if (!hud) {
        hud = [self createHUDIndicatorView:message offsetY:0];
    } else {
        hud.detailsLabel.text = message;
    }
    hud.mode = MBProgressHUDModeText;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1];
}

- (void)showTextMsgAtCenter:(NSString *)message delay:(NSTimeInterval)delay completation:(MBProgressHUDCompletionBlock)block {
    
    if ([message isEqualToString:@""] || message == nil) {
        return;
    }
    
    MBProgressHUD *hud = [self HUDAtCurrentView];
    if (!hud) {
        hud = [self createHUDIndicatorView:message offsetY:0];
    } else {
        hud.detailsLabel.text = message;
    }
    hud.completionBlock = block;
    hud.mode = MBProgressHUDModeText;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:delay];
}

- (void)showWaitStatusHUDWithMsg:(NSString *)message {
    
    if ([message isEqualToString:@""] || message == nil) {
        return;
    }
    
    MBProgressHUD *hud = [self HUDAtCurrentView];
    if (!hud) {
        hud = [self createHUDIndicatorView:message offsetY:0];
    } else {
        hud.detailsLabel.text = message;
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud showAnimated:YES];
}

- (void)showWaitStatusHUDWithMsg:(NSString *)message graceTime:(NSTimeInterval)graceTime {
    
    if ([message isEqualToString:@""] || message == nil) {
        return;
    }
    
    MBProgressHUD *hud = [self HUDAtCurrentView];
    if (!hud) {
        hud = [self createHUDIndicatorView:message offsetY:0];
    } else {
        hud.detailsLabel.text = message;
    }
    hud.graceTime = graceTime;
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud showAnimated:YES];
    
}

- (void)hideHUDView {
    MBProgressHUD *hud = [self HUDAtCurrentView];
    [hud hideAnimated:NO];
}

- (MBProgressHUD *)createHUDIndicatorView:(NSString *)title offsetY:(CGFloat)offsetY {
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self];
    hud.offset = CGPointMake(hud.offset.x, offsetY);
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabel.text = title;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16.f];
    hud.tag = hudViewTag;
    [self addSubview:hud];
    return hud;
}

- (MBProgressHUD *)HUDAtCurrentView {
    UIView *view = [self viewWithTag:hudViewTag];
    if (view && [view isKindOfClass:[MBProgressHUD class]]) {
        return (MBProgressHUD *)view;
    }
    return nil;
}

- (UIView *)viewWithTag:(NSInteger)tag {
    for (UIView *subView in self.subviews) {
        if (subView.tag == tag) {
            return subView;
            break;
        }
    }
    return nil;
}

@end
