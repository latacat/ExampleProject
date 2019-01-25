//
//  SGSMSService.h
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGBaseService.h"

NS_ASSUME_NONNULL_BEGIN

@interface SGSMSService : SGBaseService

/**
 发送验证码
 
 @param typeName 业务内容
 @param phoneNum 手机号
 @param type 1登录 2注册 其他1
 @param success 成功回调
 @param failure 失败回调
 */
- (void)sendSMSWithTypeName:(NSString *)typeName
                   phoenNum:(NSString *)phoneNum
                   sendType:(NSInteger)type
                    success:(void(^)(NSString *message))success
                    failure:(networkErrorBlock)failure;

@end

NS_ASSUME_NONNULL_END
