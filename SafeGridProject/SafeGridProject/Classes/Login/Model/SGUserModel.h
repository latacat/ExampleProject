//
//  BOUUserModel.h
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/29.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGUserModel : NSObject<NSCoding>
//用户Id
@property (nonatomic, nullable, copy) NSString *userId;
//token
@property (nonatomic, nullable, copy) NSString *userToken;
//手机号
@property (nonatomic, nullable, copy) NSString *phone;
//是否设置过密码
@property (nonatomic, nullable, copy) NSString *pasType;
//昵称
@property (nonatomic, nullable, copy) NSString *userNickName;
//生日
@property (nonatomic, nullable, copy) NSString *birthDay;
//性别 1男 2女
@property (nonatomic, nullable, copy) NSString *gender;
//头像
@property (nonatomic, nullable, copy) NSString *headImageUrl;
//真实姓名
@property (nonatomic, nullable, copy) NSString *userRealName;
//学号
@property (nonatomic, nullable, copy) NSString *userNo;
//学生状态（是否在籍 0否 1是）
@property (nonatomic, nullable, copy) NSString *userType;
//学分
@property (nonatomic, nullable, copy) NSString *score;

@end

NS_ASSUME_NONNULL_END
