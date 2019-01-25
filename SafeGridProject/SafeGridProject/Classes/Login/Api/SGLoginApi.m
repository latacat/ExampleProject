//
//  BOULoginApi.m
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/26.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import "SGLoginApi.h"
#import "NSString+MD5.h"

@interface SGLoginApi ()

@property (nonatomic, nullable, copy) NSString *accountStr;
@property (nonatomic, nullable, copy) NSString *password;
@property (nonatomic, assign) NSInteger loginType;

@end

@implementation SGLoginApi

- (instancetype)initWithAccount:(NSString *)account password:(NSString *)password logintType:(NSInteger)loginType {
    
    self = [super init];
    if (self) {
        _accountStr = account;
        _password = password;
        _loginType = loginType;
    }
    return self;
    
}

- (NSString *)requestUrl {
    
    if (self.loginType == 0) {
        return PhoneLoginUrl;
    } else {
        return AccountLoginUrl;
    }
    
}

- (id)requestArgument {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.accountStr) {
        [params setObject:self.accountStr forKey:@"keyValue"];
    }
    
    [params setObject:@(self.loginType) forKey:@"keyValue"];
    
    if (self.password) {
        if (self.loginType == 2) {
            [params setObject:self.password forKey:@"keyValue"];
        } else {
            NSString *md5Str = [NSString md5StringFromString:self.password];
            [params setObject:md5Str forKey:@"keyValue"];
        }
    }
    
    return params;
}

@end
