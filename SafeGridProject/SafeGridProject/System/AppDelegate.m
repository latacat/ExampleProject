//
//  AppDelegate.m
//  SafeGridProject
//
//  Created by zhongda on 2019/1/15.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "AppDelegate.h"

#import "ZYCBaseNavigationController.h"
#import "SGLoginViewController.h"

@import IQKeyboardManager;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [[UITextField appearance] setTintColor:ThemeColor];
    [self setupNotification];
    
    [self enterLoginController];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//登录成功，退出登录后调用通知
- (void)setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterLoginController) name:kLoginOutSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterMainController) name:kLoginSuccessNotification object:nil];
}

- (void)enterLoginController {
    SGLoginViewController *loginViewVC = [[SGLoginViewController alloc]init];
    ZYCBaseNavigationController *loginNav = [[ZYCBaseNavigationController alloc]initWithRootViewController:loginViewVC];
    self.window.rootViewController = loginNav;
}

- (void)enterMainController {
    
    UIViewController *homeVC = [[UIViewController alloc]init];
    ZYCBaseNavigationController *homeNav = [[ZYCBaseNavigationController alloc]initWithRootViewController:homeVC];
    self.window.rootViewController = homeNav;
}


@end
