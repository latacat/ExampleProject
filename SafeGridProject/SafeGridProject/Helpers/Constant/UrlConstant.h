//
//  UrlConstant.h
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/8.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UrlConstant : NSObject



FOUNDATION_EXTERN NSString *HostNameUrl;

//账号密码登录
FOUNDATION_EXTERN NSString *AccountLoginUrl;
//手机短信快捷登录
FOUNDATION_EXTERN NSString *PhoneLoginUrl;
//登出
FOUNDATION_EXTERN NSString *LogOutUrl;
//发送验证码
FOUNDATION_EXTERN NSString *SendSMSUrl;

@end

NS_ASSUME_NONNULL_END
