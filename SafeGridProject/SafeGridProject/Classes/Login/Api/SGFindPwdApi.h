//
//  SGFindPwdApi.h
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGBaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface SGFindPwdApi : SGBaseApi

- (instancetype)initWithPhone:(NSString *)phone
                     password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
