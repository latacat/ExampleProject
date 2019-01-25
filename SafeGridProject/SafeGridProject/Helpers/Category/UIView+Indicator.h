//
//  UIView+Indicator.h
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/29.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface UIView (Indicator)

- (void)showTextMsgAtCenter:(NSString *)message;

- (void)showTextMsgAtCenter:(NSString *)message delay:(NSTimeInterval)delay completation:(MBProgressHUDCompletionBlock)block;

- (void)showWaitStatusHUDWithMsg:(NSString *)message;

- (void)showWaitStatusHUDWithMsg:(NSString *)message graceTime:(NSTimeInterval)graceTime;

- (void)hideHUDView;

@end
