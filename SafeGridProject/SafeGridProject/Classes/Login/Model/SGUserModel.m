//
//  BOUUserModel.m
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/29.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import "SGUserModel.h"

@import MJExtension;

@implementation SGUserModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        _userId = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(userId))];
        _userToken = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(userToken))];
        _phone = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(phone))];
        _pasType = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(pasType))];
        _userNickName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(userNickName))];
        _birthDay = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(birthDay))];
        _gender = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(gender))];
        _headImageUrl = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(headImageUrl))];
        _userRealName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(userRealName))];
        _userNo = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(userNo))];
        _userType = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(userType))];
    }
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_userId forKey:NSStringFromSelector(@selector(userId))];
    [aCoder encodeObject:_userToken forKey:NSStringFromSelector(@selector(userToken))];
    [aCoder encodeObject:_phone forKey:NSStringFromSelector(@selector(phone))];
    [aCoder encodeObject:_pasType forKey:NSStringFromSelector(@selector(pasType))];
    [aCoder encodeObject:_userNickName forKey:NSStringFromSelector(@selector(userNickName))];
    [aCoder encodeObject:_birthDay forKey:NSStringFromSelector(@selector(birthDay))];
    [aCoder encodeObject:_gender forKey:NSStringFromSelector(@selector(gender))];
    [aCoder encodeObject:_headImageUrl forKey:NSStringFromSelector(@selector(headImageUrl))];
    [aCoder encodeObject:_userRealName forKey:NSStringFromSelector(@selector(userRealName))];
    [aCoder encodeObject:_userNo forKey:NSStringFromSelector(@selector(userNo))];
    [aCoder encodeObject:_userType forKey:NSStringFromSelector(@selector(userType))];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"userId":@"id",
             @"userToken":@"token",
             @"userNickName":@"nickName",
             @"birthDay":@"dateBirth",
             @"headImageUrl":@"imgUrl",
             @"userRealName":@"realName",
             @"userNo":@"studentNo",
             @"userType":@"studentType"
             };
}

@end
