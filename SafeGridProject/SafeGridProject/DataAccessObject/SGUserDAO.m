//
//  SNTUserDAO.m
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/29.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "SGUserDAO.h"
#import "ZYCArchiveHelper.h"

@implementation SGUserDAO

IMP_SINGLETON(SGUserDAO)

+ (SGUserModel *)userInfo {
    
    SGUserModel *userModel = [[ZYCArchiveHelper sharedInstance] unArchiveObjectWithFileName:kSaveUserInfoModelName];
    return userModel;
    
}

+ (NSString *)userId {
    
    SGUserModel *userModel = [[ZYCArchiveHelper sharedInstance] unArchiveObjectWithFileName:kSaveUserInfoModelName];
    return userModel.userId;
    
}

+ (NSString *)userHeadImageUrl {
    SGUserModel *userModel = [[ZYCArchiveHelper sharedInstance] unArchiveObjectWithFileName:kSaveUserInfoModelName];
    return userModel.headImageUrl;
}

+ (NSString *)userToken {
    
    SGUserModel *userModel = [[ZYCArchiveHelper sharedInstance] unArchiveObjectWithFileName:kSaveUserInfoModelName];
    return userModel.userToken;
    
}

+ (NSString *)userPhone {
    
    SGUserModel *userModel = [[ZYCArchiveHelper sharedInstance] unArchiveObjectWithFileName:kSaveUserInfoModelName];
    return userModel.phone;
    
}

+ (BOOL)hasPassword {
    SGUserModel *userModel = [[ZYCArchiveHelper sharedInstance] unArchiveObjectWithFileName:kSaveUserInfoModelName];
    if ([userModel.pasType isEqualToString:@"0"]) {
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)isLogined {
    
    SGUserModel *userModel = [[ZYCArchiveHelper sharedInstance]unArchiveObjectWithFileName:kSaveUserInfoModelName];
    if (userModel) {
        return YES;
    } else {
        return NO;
    }
    
}

+ (BOOL)updateHeadImageUrl:(NSString *)headImageUrl {
    
    SGUserModel *userModel = [[ZYCArchiveHelper sharedInstance]unArchiveObjectWithFileName:kSaveUserInfoModelName];
    if (headImageUrl) {
        userModel.headImageUrl = headImageUrl;
    }
    BOOL success = [[ZYCArchiveHelper sharedInstance]archiveObject:userModel fileName:kSaveUserInfoModelName];
    return success;
    
}

+ (BOOL)updateNickName:(NSString *)nickName {
    
    SGUserModel *userModel = [[ZYCArchiveHelper sharedInstance]unArchiveObjectWithFileName:kSaveUserInfoModelName];
    if (nickName) {
        userModel.userNickName = nickName;
    }
    BOOL success = [[ZYCArchiveHelper sharedInstance]archiveObject:userModel fileName:kSaveUserInfoModelName];
    return success;
    
}

+ (BOOL)updateGender:(NSString *)gender {
    
    SGUserModel *userModel = [[ZYCArchiveHelper sharedInstance]unArchiveObjectWithFileName:kSaveUserInfoModelName];
    if (gender) {
        userModel.gender = gender;
    }
    BOOL success = [[ZYCArchiveHelper sharedInstance]archiveObject:userModel fileName:kSaveUserInfoModelName];
    return success;
}

+ (BOOL)updateBirthDay:(NSString *)birthDay {
    
    SGUserModel *userModel = [[ZYCArchiveHelper sharedInstance]unArchiveObjectWithFileName:kSaveUserInfoModelName];
    if (birthDay) {
        userModel.birthDay = birthDay;
    }
    BOOL success = [[ZYCArchiveHelper sharedInstance]archiveObject:userModel fileName:kSaveUserInfoModelName];
    return success;
    
}

+ (BOOL)updateUserPhone:(NSString *)phone {
    
    SGUserModel *userModel = [[ZYCArchiveHelper sharedInstance]unArchiveObjectWithFileName:kSaveUserInfoModelName];
    if (phone) {
        userModel.phone = phone;
    }
    BOOL success = [[ZYCArchiveHelper sharedInstance]archiveObject:userModel fileName:kSaveUserInfoModelName];
    return success;
    
}

+ (BOOL)updateUserInfo:(SGUserModel *)userInfo {
    
    SGUserModel *userModel = [[ZYCArchiveHelper sharedInstance]unArchiveObjectWithFileName:kSaveUserInfoModelName];
    
    userModel.userNickName = userInfo.userNickName;
    userModel.birthDay = userInfo.birthDay;
    
    userModel.gender = userInfo.gender;
    userModel.headImageUrl = userInfo.headImageUrl;
    userModel.userRealName = userInfo.userRealName;
    userModel.userNo = userInfo.userNo;
    userModel.userType = userInfo.userType;
    userModel.score = userInfo.score;
    BOOL success = [[ZYCArchiveHelper sharedInstance]archiveObject:userModel fileName:kSaveUserInfoModelName];
    return success;
}


@end
