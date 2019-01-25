//
//  SGFindPwdApi.m
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGFindPwdApi.h"
#import "NSString+MD5.h"

@interface SGFindPwdApi ()

@property (nonatomic, nullable, copy) NSString *phone;
@property (nonatomic, nullable, copy) NSString *password;

@end

@implementation SGFindPwdApi

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password {
    
    self = [super init];
    if (self) {
        _phone = phone;
        _password = password;
    }
    return self;
    
}

- (NSString *)requestUrl {
    return @"";
}

- (id)requestArgument {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.phone) {
        [params setObject:self.phone forKey:@"keyValue"];
    }
    if (self.password) {
        NSString *md5Str = [NSString md5StringFromString:self.password];
        [params setObject:md5Str forKey:@"keyValue"];
    }
    return params;
    
}

@end
