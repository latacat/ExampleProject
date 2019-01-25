//
//  BOULoginApi.h
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/26.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import "SGBaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface SGLoginApi : SGBaseApi

/**
 登录

 @param account 账号或手机号
 @param password 密码或验证码
 @param loginType 登录类型 2 手机号验证码 1账号密码
 @return 实例
 */
- (instancetype)initWithAccount:(NSString *)account
                       password:(NSString *)password
                     logintType:(NSInteger)loginType;

@end

NS_ASSUME_NONNULL_END
