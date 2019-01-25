//
//  SGModifyPwdApi.m
//  SafeGridProject
//
//  Created by zhongda on 2019/1/22.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGModifyPwdApi.h"

@interface SGModifyPwdApi ()

@property (nonatomic, nullable, copy) NSString *originPwd;
@property (nonatomic, nullable, copy) NSString *nPassword;

@end

@implementation SGModifyPwdApi


- (instancetype)initWithOriginPwd:(NSString *)originPwd nPassword:(NSString *)nPassword {
    self = [super init];
    if (self) {
        _originPwd = originPwd;
        _nPassword = nPassword;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"";
}

- (id)requestArgument {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.originPwd) {
        [params setObject:self.originPwd forKey:@""];
    }
    if (self.nPassword) {
        [params setObject:self.nPassword forKey:@""];
    }
    return params;
}

@end
