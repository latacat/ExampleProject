//
//  SNBaseService.m
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/27.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "SGBaseService.h"
#import "HttpBaseModel.h"
#import "NSString+AES.h"
#import "NSString+RSA.h"
#import "DeviceUUID.h"

#import "SGLoginHelper.h"

@import AFNetworking;

static NSString *const RESULT_DATA_KEY = @"data";
static NSString *const RESULT_NEED_DECRYPT_KEY = @"dataType";

static NSString *ErrorDomainStr = @"com.zhongdayingcai.beikai";

@implementation SGBaseService

- (NSDictionary *)requestHeaderFieldValue {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //7D31E9C0-430F-41A6-A347-0B0F4729A596
    NSString *uuid = [DeviceUUID takeDeviceUUID];
    NSString *userId = [SGUserDAO userId];
    NSString *userToken = [SGUserDAO userToken];
    NSDictionary *headDict = @{@"version":app_Version,
                               @"equipNum":uuid,
                               @"userid":userId?:@"",
                               @"token":userToken?:@"",
                               @"devicetype":@"2"
                               };
    return headDict;
    
}

- (void)parseResponseData:(id)responseData success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    HttpBaseModel *baseModel = [HttpBaseModel mj_objectWithKeyValues:responseData];
    if (baseModel.errorCode && [baseModel.errorCode isEqualToString:@"000000"]) {
        
        id resultDict = nil;
        //        NSData *jsonData = [baseModel.responseData dataUsingEncoding:NSUTF8StringEncoding];
        //        if (jsonData) {
        //            resultDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
        //        }
        resultDict = baseModel.responseData;
        
        if (success) {
            success(resultDict);
        }
        
        
    } else if (baseModel.errorCode && [baseModel.errorCode isEqualToString:@"100001"]) {
        
        NSError *errorInfo = [self showErrorInfoWithMsg:@""];
        if (failure) {
            failure(errorInfo);
        }
        
        if ([SGUserDAO userInfo]) {
            [[ZYCArchiveHelper sharedInstance] deleteArchiveFileWithFileName:kSaveUserInfoModelName];
//            [SGOffineTipsView showOffineAlertViewWithTitle:nil message:nil leftClickBlock:^(UIButton *sender) {
//                
//                [[SGLoginHelper sharedInstance] userLogOut];
//                
//            } rightClickBlock:^(UIButton *sender) {
//                
//                [[SGLoginHelper sharedInstance] userLoginBackIn];
//            }];
        }
        
    } else {
        NSDictionary *userInfo = nil;
        if (baseModel.errorMsg) {
            userInfo = @{@"errMsg":baseModel.errorMsg};
        }
        userInfo = [NSDictionary dictionaryWithObjectsAndKeys:baseModel.errorMsg, NSLocalizedDescriptionKey, nil];
        NSError *domainError = [NSError errorWithDomain:ErrorDomainStr code:baseModel.errorCode.integerValue userInfo:userInfo];
        
        if (failure) {
            failure(domainError);
        }
    }
}


- (NSError *)showErrorInfo {
    
    NSDictionary *errorInfo = @{NSLocalizedDescriptionKey:@"网络请求失败"};
    NSError *error = [NSError errorWithDomain:ErrorDomainStr code:-1001 userInfo:errorInfo];
    return error;
    
}

- (NSError *)showErrorInfoWithMsg:(NSString *)message {
    
    NSDictionary *errorInfo = @{NSLocalizedDescriptionKey:message};
    NSError *error = [NSError errorWithDomain:ErrorDomainStr code:-1001 userInfo:errorInfo];
    return error;
    
}

- (NSError *)showErrorInfoWithMsg:(NSString *)message code:(NSInteger)errorCode {
    
    NSDictionary *errorInfo = @{NSLocalizedDescriptionKey:message};
    NSError *error = [NSError errorWithDomain:ErrorDomainStr code:errorCode userInfo:errorInfo];
    return error;
    
}

#pragma mark - getter

- (NSError *)noNetworkError {
    AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    
    if (status == AFNetworkReachabilityStatusNotReachable) {
        _noNetworkError = [self showErrorInfoWithMsg:@"网络链接失败，请检查网络" code:-2];
    } else {
        _noNetworkError = nil;
    }
    return _noNetworkError;
}

@end
