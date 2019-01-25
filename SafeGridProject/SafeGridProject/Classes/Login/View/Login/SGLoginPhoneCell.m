//
//  SGLoginPhoneCell.m
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGLoginPhoneCell.h"

@interface SGLoginPhoneCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerV;

@end

@implementation SGLoginPhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.phoneTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.containerV.layer.borderColor = ThemeColor.CGColor;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.containerV.layer.borderColor = COLOR_WITH_HEX(0xCCCCCC).CGColor;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField.text.length >= 11) {
        return NO;
    }
    return YES;
}

@end
