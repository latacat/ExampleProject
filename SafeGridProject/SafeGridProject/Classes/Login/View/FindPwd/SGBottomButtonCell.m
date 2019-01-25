//
//  SGBottomButtonCell.m
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGBottomButtonCell.h"

@interface SGBottomButtonCell ()

@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;


@end

@implementation SGBottomButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setButtonEnabled:(BOOL)buttonEnabled {
    _buttonEnabled = buttonEnabled;
    self.btnSubmit.enabled = buttonEnabled;
}

- (IBAction)clickSubmitAction:(UIButton *)sender {
    
    if (self.submitClickBlock) {
        self.submitClickBlock();
    }
}

@end
