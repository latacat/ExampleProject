//
//  NotificationConstant.h
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/26.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationConstant : NSObject
//登录界面手机号输入完成
FOUNDATION_EXTERN NSString *kLoginInputPhoneSuccessNotification;
//登录成功通知
FOUNDATION_EXTERN NSString *kLoginSuccessNotification;
//通过重新登录成功通知
FOUNDATION_EXTERN NSString *kReLoginSuccessNotification;
//登出成功通知
FOUNDATION_EXTERN NSString *kLoginOutSuccessNotification;
//修改昵称成功
FOUNDATION_EXTERN NSString *kModifyNickNameSuccessNotification;
//选择头像照片完成
FOUNDATION_EXTERN NSString *kSelectedAvatarSuccessNotification;
//修改头像完成
FOUNDATION_EXTERN NSString *kModifyAvatarSuccessNotification;
//找回密码成功
FOUNDATION_EXTERN NSString *kFindPasswordSuccessNotification;
//设置密码密码成功
FOUNDATION_EXTERN NSString *kFirstSettingPasswordSuccessNotification;
@end

NS_ASSUME_NONNULL_END
