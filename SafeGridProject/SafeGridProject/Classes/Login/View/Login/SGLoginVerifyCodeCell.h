//
//  SGLoginVerifyCodeCell.h
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGLoginVerifyCodeCell;
@protocol SGLoginVerifyCodeCellDelegate <NSObject>

@optional;
- (void)verifyCodeCell:(SGLoginVerifyCodeCell *)cell clickSendCode:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_BEGIN

@interface SGLoginVerifyCodeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTxtField;
@property (weak, nonatomic) IBOutlet UIButton *btnGetCode;

@property (nonatomic, assign) NSInteger phoneLength;

@property (nonatomic, nullable, weak) id<SGLoginVerifyCodeCellDelegate> delegate;

- (void)judgeSendCodeButtonStatusWithPhoneLength:(NSInteger)phoneLength;

- (void)changeColorToNormal;

- (void)changeColorToRed;

@end

NS_ASSUME_NONNULL_END
