//
//  SGLoginBottomCell.h
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SGLoginStyle) {
    SGLoginStylePhonePassword,
    SGLoginStylePhoneVerify,
};

@class SGLoginBottomCell;

@protocol SGLoginBottomCellDelegate <NSObject>

@optional

- (void)bottomCell:(SGLoginBottomCell *)loginBottomCell switchLoginStyle:(SGLoginStyle)loginStyle;

- (void)bottomCell:(SGLoginBottomCell *)loginBottomCell clickForgetPwd:(UIButton *)sender;

- (void)bottomCell:(SGLoginBottomCell *)loginBottomCell clickLogin:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_BEGIN

@interface SGLoginBottomCell : UITableViewCell

@property (nonatomic, assign) SGLoginStyle loginStyle;

@property (nonatomic, nullable, weak) id<SGLoginBottomCellDelegate> delegate;

@property (nonatomic, assign) BOOL loginButtonEnabled;

@end

NS_ASSUME_NONNULL_END
