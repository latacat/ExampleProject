//
//  SGLoginViewController.h
//  SafeGridProject
//
//  Created by zhongda on 2019/1/15.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "ZYCBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SGLoginViewController : ZYCBaseViewController

@property (nonatomic, nullable, copy) void(^dismissBlock)(void);

@end

NS_ASSUME_NONNULL_END
