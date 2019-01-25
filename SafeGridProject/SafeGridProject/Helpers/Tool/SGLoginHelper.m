//
//  SGLoginHelper.m
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/12/5.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import "SGLoginHelper.h"
#import "UIView+Indicator.h"

#import "ZYCBaseNavigationController.h"
#import "SGLoginViewController.h"

@interface SGLoginHelper ()

@end

@implementation SGLoginHelper

IMP_SINGLETON(SGLoginHelper);

- (void)userLogOut {
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginOutSuccessNotification object:nil];
    
}

- (void)tipsUserLogin {
    SGLoginViewController *loginVC = [[SGLoginViewController alloc] init];

    //设置导航控制器的根控制器
    ZYCBaseNavigationController *loginNav = [[ZYCBaseNavigationController alloc]initWithRootViewController:loginVC];
    //模态的形式进去
    [[SGLoginHelper visibleVC] presentViewController:loginNav animated:YES completion:nil];
}

- (void)tipsUserLoginWithCompleteHandler:(void (^)(void))block alreadyBlock:(nonnull void (^)(void))alreadyBolck  {
    
    BOOL isLogined = [SGUserDAO isLogined];
    if (!isLogined) {
        SGLoginViewController *loginVC = [[SGLoginViewController alloc] init];

        //设置导航控制器的根控制器
        ZYCBaseNavigationController *loginNav = [[ZYCBaseNavigationController alloc]initWithRootViewController:loginVC];
        //模态的形式进去
        loginVC.dismissBlock = block;
        [[SGLoginHelper visibleVC] presentViewController:loginNav animated:YES completion:nil];
    } else {
        if (alreadyBolck) {
            alreadyBolck();
        }
    }
    
}

- (void)userLoginBackIn {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginOutSuccessNotification object:nil];
    SGLoginViewController *loginVC = [[SGLoginViewController alloc] init];
    //现在点击重新登录是先退回到首页，然后弹出登录界面，当不需要退到首页时，设置此属性为yes则在重新登录成功以后会跳转到首页
//    loginVC.isReLogin = YES;
    //设置导航控制器的根控制器
    ZYCBaseNavigationController *loginNav = [[ZYCBaseNavigationController alloc]initWithRootViewController:loginVC];
    //模态的形式进去
    [[SGLoginHelper visibleVC] presentViewController:loginNav animated:YES completion:nil];
}

+ (UIViewController *)visibleVC{
    
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    return [SGLoginHelper getVisibleViewControllerFrom:rootViewController];
}

+ (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [SGLoginHelper getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [SGLoginHelper getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [SGLoginHelper getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

@end
