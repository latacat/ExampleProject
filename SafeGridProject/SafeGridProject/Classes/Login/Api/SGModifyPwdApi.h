//
//  SGModifyPwdApi.h
//  SafeGridProject
//
//  Created by zhongda on 2019/1/22.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGBaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface SGModifyPwdApi : SGBaseApi

- (instancetype)initWithOriginPwd:(NSString *)originPwd
                        nPassword:(NSString *)nPassword;

@end

NS_ASSUME_NONNULL_END
