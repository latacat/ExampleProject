//
//  SGTimerManager.m
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/12/3.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import "SGTimerManager.h"

#define kMaxCountDownTime           10

@interface SGTimerManager ()

@property (nonatomic, assign) SGCountDownType countDonwnType;

@property (nonatomic, nullable, strong) dispatch_source_t loginTimer;

@property (nonatomic, nullable, strong) dispatch_source_t findPwdTimer;

@property (nonatomic, nullable, strong) dispatch_source_t registerTimer;

@property (nonatomic, nullable, strong) dispatch_source_t modifyPhoneTimer;

@end

@implementation SGTimerManager

IMP_SINGLETON(SGTimerManager);

- (void)timerCountDownWithType:(SGCountDownType)countDownType {
    
    _countDonwnType = countDownType;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    NSTimeInterval seconds = kMaxCountDownTime;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds];
    dispatch_source_set_event_handler(_timer, ^{
    
        int interval = [endTime timeIntervalSinceNow];
        if (interval <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([_timer isEqual:self.loginTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginCountDownCompletedNotification object:@(interval)];
                } else if ([_timer isEqual:self.findPwdTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kFindPasswordCountDownCompletedNotification object:@(interval)];
                } else if ([_timer isEqual:self.registerTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kRegisterCountDownCompletedNotification object:@(interval)];
                } else if ([_timer isEqual:self.modifyPhoneTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kModifyPhoneCountDownCompletedNotification object:@(interval)];
                }
            
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([_timer isEqual:self.loginTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginCountDownExecutingNotification object:@(interval)];
                } else if ([_timer isEqual:self.findPwdTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kFindPasswordCountDownExecutingNotification object:@(interval)];
                } else if ([_timer isEqual:self.registerTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kRegisterCountDownExecutingNotification object:@(interval)];
                } else if ([_timer isEqual:self.modifyPhoneTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kModifyPhoneCountDownExecutingNotification object:@(interval)];
                }
                
            });
        }
    });
    
    if (self.countDonwnType == SGCountDownTypeLogin) {
        self.loginTimer = _timer;
    } else if (self.countDonwnType == SGCountDownTypeFindPassword) {
        self.findPwdTimer = _timer;
    } else if (self.countDonwnType == SGCountDownTypeRegister) {
        self.registerTimer = _timer;
    } else if (self.countDonwnType == SGCountDownTypeModifyPhone) {
        self.modifyPhoneTimer = _timer;
    }
    
    dispatch_resume(_timer);
}

- (void)cancelTimerWithType:(SGCountDownType)countDownType {
    switch (countDownType) {
        case SGCountDownTypeLogin:
            if (self.loginTimer) {
                dispatch_source_cancel(self.loginTimer);
            }
            
            break;
        case SGCountDownTypeRegister:
            if (self.registerTimer) {
                dispatch_source_cancel(self.registerTimer);
            }
            
            break;
        case SGCountDownTypeModifyPhone:
            if (self.modifyPhoneTimer) {
                dispatch_source_cancel(self.modifyPhoneTimer);
            }
            
            break;
        case SGCountDownTypeFindPassword:
            if (self.findPwdTimer) {
                dispatch_source_cancel(self.findPwdTimer);
            }
            
            break;
        default:
            break;
    }
}

@end
