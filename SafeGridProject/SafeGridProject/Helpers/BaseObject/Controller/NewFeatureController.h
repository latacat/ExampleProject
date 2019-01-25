//
//  NewFeatureController.h
//  JingHuaTimes
//
//  Created by zhouyongchao on 16/1/26.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeatureController : UIViewController

@property (copy, nonatomic) void (^ZYCBasicBlock)(void);

- (void)showNewFeatureToWindow:(UIWindow *)window;

@end
