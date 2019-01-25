//
//  SGLoginService.h
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGBaseService.h"

NS_ASSUME_NONNULL_BEGIN

@interface SGLoginService : SGBaseService

/**
 登录
 
 @param account 账号或手机号
 @param password 密码或验证码
 @param loginType 登录类型
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
              logintType:(NSInteger)loginType
                 success:(void(^)(void))success
                 failure:(networkErrorBlock)failure;


/**
 登出
 
 @param success 成功回调
 @param failure 失败回调
 */
- (void)logOutSuccess:(void(^)(void))success
              failure:(networkErrorBlock)failure;

/**
 找回密码
 
 @param phone 手机号
 @param password 密码
 @param success 成功回调
 @param failure 失败回调
 */
-(void)findPasswordWithPhone:(NSString *)phone
                     password:(NSString *)password
                      success:(void(^)(NSString *message))success
                      failure:(networkErrorBlock)failure;

/**
 修改密码

 @param oldPassword 旧密码
 @param nPassword 新密码
 @param success 成功回调
 @param failure 失败回调
 */
- (void)modifyPwdWithOldPassword:(NSString *)oldPassword
                       nPassword:(NSString *)nPassword
                         success:(void(^)(NSString *message))success
                         failure:(networkErrorBlock)failure;

@end

NS_ASSUME_NONNULL_END
