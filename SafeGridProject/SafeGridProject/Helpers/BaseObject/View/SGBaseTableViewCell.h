//
//  SGBaseTableViewCell.h
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/26.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGMySelfIndexCellBackGroundView : UIView

@end


@import Masonry;
@interface SGBaseTableViewCell : UITableViewCell

@property (nonatomic, nullable, strong) SGMySelfIndexCellBackGroundView *cusBackgroundView;

@property (nonatomic, nullable, strong) UILabel *lblLeftTitle;

@property (nonatomic, assign) BOOL hideSeparatorLine;

@property (nonatomic, nullable, copy) NSString *leftTitle;

@end

NS_ASSUME_NONNULL_END
