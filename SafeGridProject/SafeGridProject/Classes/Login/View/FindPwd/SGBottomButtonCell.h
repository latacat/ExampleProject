//
//  SGBottomButtonCell.h
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGBottomButtonCell : UITableViewCell

@property (nonatomic, assign) BOOL buttonEnabled;

@property (nonatomic, nullable, copy) void(^submitClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
