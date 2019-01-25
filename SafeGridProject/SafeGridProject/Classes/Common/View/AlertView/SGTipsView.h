//
//  SGTipsView.h
//  SafeGridProject
//
//  Created by zhongda on 2019/1/22.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGTipsView : UIView

@property (nonatomic, copy) NSString *tipsTitle;

@property (nonatomic, copy) NSString *tipsMessage;

@property (nonatomic, copy) NSString *leftButtonTitle;

@property (nonatomic, copy) NSString *rightButtonTitle;

@property (nonatomic, copy) void(^leftButtonClickedBlock)(UIButton *sender);

@property (nonatomic, copy) void(^rightButtonClickedBlock)(UIButton *sender);

+ (SGTipsView *)shareInstance;

+ (instancetype)showTipsViewWithTitle:(NSString *)title
                       leftClickBlock:(void(^)(UIButton *sender))leftBlock
                      rightClickBlock:(void(^)(UIButton *sender))rightBlock;

+ (instancetype)showTipsViewWithTitle:(NSString *)title
                      leftButtonTitle:(NSString *)leftButtonTitle
                     rightButtonTitle:(NSString *)rightButtonTitle
                       leftClickBlock:(void(^)(UIButton *sender))leftBlock
                      rightClickBlock:(void(^)(UIButton *sender))rightBlock;

@end
