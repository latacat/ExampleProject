//
//  SGPickerAlertView.m
//  SafeGridProject
//
//  Created by zhongda on 2019/1/22.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGPickerAlertView.h"

@interface SGPickerAlertView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic, nullable, copy) NSArray<id<SGPickerAlertViewProtocol>> *contentArr;
@property (nonatomic, nullable, strong) id<SGPickerAlertViewProtocol> selectedContent;

@end

static SGPickerAlertView *_instance = nil;

@implementation SGPickerAlertView

+ (SGPickerAlertView *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SGPickerAlertView class]) owner:nil options:nil].firstObject;
    });
    return _instance;
}

+ (instancetype)showPickerAlertViewWithContentArr:(NSArray<id<SGPickerAlertViewProtocol>> *)contentArr
                                 cancelClickBlock:(void(^)(UIButton *sender))leftBlock
                                   sureClickBlock:(void(^)(UIButton *sender, NSString *selectedId))rightBlock; {
    
    SGPickerAlertView *pickerAlerView = [SGPickerAlertView shareInstance];
    pickerAlerView.contentArr = contentArr;
    pickerAlerView.leftButtonClickedBlock = leftBlock;
    pickerAlerView.rightButtonClickedBlock = rightBlock;
    
    pickerAlerView.pickerView.dataSource = pickerAlerView;
    pickerAlerView.pickerView.delegate = pickerAlerView;
    
    UIView *parentView = [UIApplication sharedApplication].keyWindow;
    
    if (![pickerAlerView isDescendantOfView:parentView]) {
        [pickerAlerView showAlertViewWithView:parentView];
    }
    
    return pickerAlerView;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.contentArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    id<SGPickerAlertViewProtocol> content = self.contentArr[row];
    return content.pickerAlertViewRowContent;
    
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40.f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    id<SGPickerAlertViewProtocol> content = self.contentArr[row];
    if (content) {
        self.selectedContent = content;
    }
}

#pragma mark - event method

- (IBAction)rightAction:(UIButton *)sender {
    
    [self hideAlertViewCompleteHandler:^{
        if (self.rightButtonClickedBlock) {
            self.rightButtonClickedBlock(sender, self.selectedContent.pickerAlertViewRowId);
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

#pragma mark - animation

- (void)showAlertViewWithView:(UIView *)fatherView {
    
    self.frame = fatherView.frame;
    [fatherView addSubview:self];
    
    self.bottomConstraint.constant = -50.f;

    [UIView animateWithDuration:0.35 animations:^{
        
        [self layoutIfNeeded];
    }];
}

- (void)hideAlertViewCompleteHandler:(void (^)(void))complete {
    
    self.bottomConstraint.constant = -320.f;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        if (complete) {
            complete();
        }
    }];
}

@end
