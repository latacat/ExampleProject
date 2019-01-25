//
//  UIView+AlertTipsAnimation.h
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/28.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (AlertTipsAnimation)

- (void)showAlertViewWithView:(UIView *)fatherView;

- (void)hideAlertViewCompleteHandler:(void (^)(void))complete;

@end

