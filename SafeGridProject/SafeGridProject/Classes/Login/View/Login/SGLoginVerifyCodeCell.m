//
//  SGLoginVerifyCodeCell.m
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGLoginVerifyCodeCell.h"

@interface SGLoginVerifyCodeCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerV;
@property (weak, nonatomic) IBOutlet UIView *containerV1;

@property (nonatomic, nullable, strong) CAShapeLayer *leftContainerSubLayer;
@property (nonatomic, nullable, strong) CAShapeLayer *containerV1SubLayer;

@end

@implementation SGLoginVerifyCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.verifyCodeTxtField.delegate = self;
    self.containerV1SubLayer = [CAShapeLayer layer];
    self.containerV1SubLayer.strokeColor = COLOR_WITH_HEX(0xCCCCCC).CGColor;
    
    self.leftContainerSubLayer = [CAShapeLayer layer];
    self.leftContainerSubLayer.strokeColor = COLOR_WITH_HEX(0xCCCCCC).CGColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.containerV1 layoutIfNeeded];
    [self.containerV layoutIfNeeded];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.containerV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(10.f, 10.f)];

    self.leftContainerSubLayer.lineWidth = .5f;
    self.leftContainerSubLayer.fillColor = [UIColor clearColor].CGColor;
    self.leftContainerSubLayer.strokeColor = COLOR_WITH_HEX(0xCCCCCC).CGColor;
    self.leftContainerSubLayer.frame = self.containerV.bounds;
    self.leftContainerSubLayer.path = bezierPath.CGPath;
    [self.containerV.layer addSublayer:self.leftContainerSubLayer];
    
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.frame = self.containerV.bounds;
    shaperLayer.path = bezierPath.CGPath;
    self.containerV.layer.mask = shaperLayer;
    
    UIBezierPath *rightPath = [UIBezierPath bezierPathWithRoundedRect:self.containerV1.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10.f, 10.f)];
    self.containerV1SubLayer.lineWidth = .5f;
    self.containerV1SubLayer.fillColor = [UIColor clearColor].CGColor;
    self.containerV1SubLayer.frame = self.containerV1.bounds;
    self.containerV1SubLayer.path = rightPath.CGPath;
    
    [self.containerV1.layer addSublayer:self.containerV1SubLayer];
    
    CAShapeLayer *tempShaperLayer = [CAShapeLayer layer];
    tempShaperLayer.frame = self.containerV1.bounds;
    tempShaperLayer.path = rightPath.CGPath;
    self.containerV1.layer.mask = tempShaperLayer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - private method

- (IBAction)clickSendCodeAction:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(verifyCodeCell:clickSendCode:)]) {
        [_delegate verifyCodeCell:self clickSendCode:sender];
    }
}

#pragma mark - public method

- (void)judgeSendCodeButtonStatusWithPhoneLength:(NSInteger)phoneLength {
    if (phoneLength == 11 && [self.btnGetCode.titleLabel.text isEqualToString:@"获取验证码"]) {
        self.btnGetCode.userInteractionEnabled = YES;
        [self changeColorToRed];
    } else {
        self.btnGetCode.userInteractionEnabled = NO;
        [self changeColorToNormal];
    }
}

- (void)changeColorToNormal {
    [self.btnGetCode setTitleColor:COLOR_WITH_HEX(0x999999) forState:UIControlStateNormal];
    self.containerV1SubLayer.strokeColor = COLOR_WITH_HEX(0xCCCCCC).CGColor;
}

- (void)changeColorToRed {
    [self.btnGetCode setTitleColor:COLOR_WITH_HEX(0xE5473C) forState:UIControlStateNormal];
    self.containerV1SubLayer.strokeColor = COLOR_WITH_HEX(0xE5473C).CGColor;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.leftContainerSubLayer.strokeColor = ThemeColor.CGColor;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.leftContainerSubLayer.strokeColor = COLOR_WITH_HEX(0xCCCCCC).CGColor;
}

#pragma mark - setter

- (void)setPhoneLength:(NSInteger)phoneLength {
    _phoneLength = phoneLength;
    [self judgeSendCodeButtonStatusWithPhoneLength:phoneLength];
}

@end
