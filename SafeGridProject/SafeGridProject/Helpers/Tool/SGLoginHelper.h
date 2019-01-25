//
//  SGLoginHelper.h
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/12/5.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SGLoginHelper : NSObject

DEF_SINGLETON(SGLoginHelper);
//登出
- (void)userLogOut;
//重新登录
- (void)userLoginBackIn;
//提示用户登录
- (void)tipsUserLogin;

- (void)tipsUserLoginWithCompleteHandler:(void(^)(void))block alreadyBlock:(void(^)(void))alreadyBolck;

+ (UIViewController *)visibleVC;

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc;

@end

