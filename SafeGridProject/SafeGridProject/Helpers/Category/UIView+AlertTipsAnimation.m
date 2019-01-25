//
//  UIView+AlertTipsAnimation.m
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/28.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import "UIView+AlertTipsAnimation.h"

@implementation UIView (AlertTipsAnimation)

- (void)showAlertViewWithView:(UIView *)fatherView {
    
    self.frame = fatherView.bounds;
    self.alpha = 0.f;
    [fatherView addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.f;
    }];
}

- (void)hideAlertViewCompleteHandler:(void (^)(void))complete {
    
    self.alpha = 1;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        if (complete) {
            complete();
        }
    }];
}

@end
