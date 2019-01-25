//
//  SNBaseApi.m
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/27.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "SGBaseApi.h"

@implementation SGBaseApi

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    if (_baseApiProtocol && [_baseApiProtocol respondsToSelector:@selector(requestHeaderFieldValue)]) {
        return [_baseApiProtocol requestHeaderFieldValue];
    }
    return nil;
}

- (void)setSecretParams:(NSDictionary *)secretParams inParmas:(NSMutableDictionary *)originParams {
    
    NSString *aesKey = @"";
    NSString *userId = @"";
    if (userId) {
        [originParams setObject:userId forKey:@"uId"];
    }
    if (secretParams) {
        [originParams setObject:[NSString encryptAES:secretParams.mj_JSONString key:aesKey] forKey:KEY_ENCRYPT_DATA];
    }
}

@end
