//
//  SNTUserDAO.h
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/29.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalMacro.h"

#import "SGUserModel.h"

#define kSaveUserInfoModelName   @"BJOUUserInfo"

@interface SGUserDAO : NSObject

DEF_SINGLETON(SGUserDAO)

+ (SGUserModel *)userInfo;

+ (NSString *)userId;

+ (NSString *)userHeadImageUrl;

+ (NSString *)userToken;

+ (NSString *)userPhone;

+ (BOOL)hasPassword;

+ (BOOL)isLogined;

+ (BOOL)updateHeadImageUrl:(NSString *)headImageUrl;

+ (BOOL)updateGender:(NSString *)gender;

+ (BOOL)updateBirthDay:(NSString *)birthDay;

+ (BOOL)updateNickName:(NSString *)nickName;

+ (BOOL)updateUserPhone:(NSString *)phone;

+ (BOOL)updateUserInfo:(SGUserModel *)userInfo;

@end
