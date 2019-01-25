//
//  SGTimerManager.h
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/12/3.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kLoginCountDownCompletedNotification            @"kLoginCountDownCompletedNotification"
#define kFindPasswordCountDownCompletedNotification     @"kFindPasswordCountDownCompletedNotification"
#define kRegisterCountDownCompletedNotification            @"kRegisterCountDownCompletedNotification"
#define kModifyPhoneCountDownCompletedNotification            @"kModifyPhoneCountDownCompletedNotification"

#define kLoginCountDownExecutingNotification            @"kLoginCountDownExecutingNotification"
#define kFindPasswordCountDownExecutingNotification     @"kFindPasswordCountDownExecutingNotification"
#define kRegisterCountDownExecutingNotification            @"kRegisterCountDownExecutingNotification"
#define kModifyPhoneCountDownExecutingNotification            @"kModifyPhoneCountDownExecutingNotification"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SGCountDownType) {
    SGCountDownTypeLogin,
    SGCountDownTypeFindPassword,
    SGCountDownTypeRegister,
    SGCountDownTypeModifyPhone,
};


@interface SGTimerManager : NSObject

DEF_SINGLETON(SGTimerManager);

- (void)timerCountDownWithType:(SGCountDownType)countDownType;

- (void)cancelTimerWithType:(SGCountDownType)countDownType;

@end

NS_ASSUME_NONNULL_END
