//
//  SGLoginPwdCell.h
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGLoginPwdCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (nonatomic, nullable, copy) NSString *placeHolderStr;

- (void)resetStatus;

@end

NS_ASSUME_NONNULL_END
