//
//  SGLoginPwdCell.m
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGLoginPwdCell.h"

@interface SGLoginPwdCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerV;
@property (weak, nonatomic) IBOutlet UIButton *btnShowOrHidePwd;

@end

@implementation SGLoginPwdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.pwdTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.containerV.layer.borderColor = ThemeColor.CGColor;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.containerV.layer.borderColor = COLOR_WITH_HEX(0xCCCCCC).CGColor;
}

- (IBAction)changeSecurityAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.pwdTextField.secureTextEntry = NO;
    } else {
        self.pwdTextField.secureTextEntry = YES;
    }
}

- (void)resetStatus {
    self.btnShowOrHidePwd.selected = NO;
    self.pwdTextField.secureTextEntry = YES;
}

#pragma mark - setter

- (void)setPlaceHolderStr:(NSString *)placeHolderStr {
    _placeHolderStr = [placeHolderStr copy];
    self.pwdTextField.placeholder = placeHolderStr;
}

@end
