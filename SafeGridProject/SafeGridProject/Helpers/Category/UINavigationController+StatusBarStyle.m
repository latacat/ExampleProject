//
//  UINavigationController+StatusBarStyle.m
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/23.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import "UINavigationController+StatusBarStyle.h"

@implementation UINavigationController (StatusBarStyle)

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

@end
