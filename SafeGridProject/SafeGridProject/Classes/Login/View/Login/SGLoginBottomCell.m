//
//  SGLoginBottomCell.m
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGLoginBottomCell.h"

@interface SGLoginBottomCell ()
@property (weak, nonatomic) IBOutlet UIButton *btnLoginStyle;
@property (weak, nonatomic) IBOutlet UIButton *btnForget;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation SGLoginBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickLogin:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(bottomCell:clickLogin:)]) {
        [_delegate bottomCell:self clickLogin:sender];
    }
}

- (IBAction)clickForgetAction:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(bottomCell:clickForgetPwd:)]) {
        [_delegate bottomCell:self clickForgetPwd:sender];
    }
}

- (IBAction)switchLoginStyleAction:(UIButton *)sender {
    
    if (self.loginStyle == SGLoginStylePhonePassword) {
        self.loginStyle = SGLoginStylePhoneVerify;
    } else {
        self.loginStyle = SGLoginStylePhonePassword;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(bottomCell:switchLoginStyle:)]) {
        [_delegate bottomCell:self switchLoginStyle:self.loginStyle];
    }
}

#pragma mark - setter

- (void)setLoginStyle:(SGLoginStyle)loginStyle {
    _loginStyle = loginStyle;
    if (loginStyle == SGLoginStylePhoneVerify) {
        self.btnForget.hidden = YES;
    } else {
        self.btnForget.hidden = NO;
    }
}

- (void)setLoginButtonEnabled:(BOOL)loginButtonEnabled {
    _loginButtonEnabled = loginButtonEnabled;
    self.btnLogin.enabled = loginButtonEnabled;
}

@end
