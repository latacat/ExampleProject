//
//  BOUSendSMSApi.m
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/30.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import "SGSendSMSApi.h"

@interface SGSendSMSApi ()

@property (nonatomic, nullable, copy) NSString *typeName;
@property (nonatomic, nullable, copy) NSString *phoneNum;
@property (nonatomic, assign) NSInteger type;

@end

@implementation SGSendSMSApi

- (instancetype)initWithTypeName:(NSString *)typeName
                        phoenNum:(NSString *)phoneNum
                        sendType:(NSInteger)type {
    
    self = [super init];
    if (self) {
        _typeName = typeName;
        _phoneNum = phoneNum;
        _type = type;
    }
    return self;
    
}

- (NSString *)requestUrl {
    return SendSMSUrl;
}

- (id)requestArgument {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.typeName) {
        [params setObject:self.typeName forKey:@"keyValue"];
    }
    if (self.phoneNum) {
        [params setObject:self.phoneNum forKey:@"keyValue"];
    }
    [params setObject:@(self.type) forKey:@"keyValue"];
    [params setObject:@(1) forKey:@"keyValue"];
    return params;
}

@end
