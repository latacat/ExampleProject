//
//  SGTipsView.m
//  SafeGridProject
//
//  Created by zhongda on 2019/1/22.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGTipsView.h"
#import "UIView+AlertTipsAnimation.h"

static SGTipsView *_instance = nil;

@interface SGTipsView ()

@property (weak, nonatomic) IBOutlet UILabel *lblTipsContent;
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;

@end

@implementation SGTipsView

+ (SGTipsView *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SGTipsView class]) owner:nil options:nil].firstObject;
    });
    return _instance;
}

+ (instancetype)showTipsViewWithTitle:(NSString *)title
                       leftClickBlock:(void (^)(UIButton *))leftBlock
                      rightClickBlock:(void (^)(UIButton *))rightBlock {
    
    SGTipsView *tipsView = [SGTipsView shareInstance];
    if (title) {
        tipsView.tipsTitle = title;
    }
    
    tipsView.leftButtonClickedBlock = leftBlock;
    tipsView.rightButtonClickedBlock = rightBlock;
    
    UIView *parentView = [UIApplication sharedApplication].keyWindow;
    
    if (![tipsView isDescendantOfView:parentView]) {
        [tipsView showAlertViewWithView:parentView];
    }
    
    return tipsView;
}

+ (instancetype)showTipsViewWithTitle:(NSString *)title
                      leftButtonTitle:(NSString *)leftButtonTitle
                     rightButtonTitle:(NSString *)rightButtonTitle
                       leftClickBlock:(void (^)(UIButton *))leftBlock
                      rightClickBlock:(void (^)(UIButton *))rightBlock {
    
    SGTipsView *tipsView = [SGTipsView shareInstance];
    tipsView.lblTipsContent.text = title;
    tipsView.leftButtonTitle = leftButtonTitle;
    tipsView.rightButtonTitle = rightButtonTitle;
    tipsView.leftButtonClickedBlock = leftBlock;
    tipsView.rightButtonClickedBlock = rightBlock;
    
    UIView *parentView = [UIApplication sharedApplication].keyWindow;
    
    if (![tipsView isDescendantOfView:parentView]) {
        [tipsView showAlertViewWithView:parentView];
    }
    
    return tipsView;
}

- (IBAction)rightAction:(UIButton *)sender {
    
    [self hideAlertViewCompleteHandler:^{
        if (self.rightButtonClickedBlock) {
            self.rightButtonClickedBlock(sender);
        }
    }];
}

- (IBAction)leftAction:(UIButton *)sender {
    
    if (self.leftButtonClickedBlock) {
        self.leftButtonClickedBlock(sender);
    } else {
        [self hideAlertViewCompleteHandler:nil];
    }
    
}

#pragma mark - setter

- (void)setTipsTitle:(NSString *)tipsTitle {
    
    _tipsTitle = [tipsTitle copy];
    self.lblTipsContent.text = tipsTitle;
}

- (void)setLeftButtonTitle:(NSString *)leftButtonTitle {
    
    _leftButtonTitle = [leftButtonTitle copy];
    
    [self.btnLeft setTitle:leftButtonTitle forState:UIControlStateNormal];
}

- (void)setRightButtonTitle:(NSString *)rightButtonTitle {
    
    _rightButtonTitle = [rightButtonTitle copy];
    
    [self.btnRight setTitle:rightButtonTitle forState:UIControlStateNormal];
}

@end
