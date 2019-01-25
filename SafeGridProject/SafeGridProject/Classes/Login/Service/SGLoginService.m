//
//  SGLoginService.m
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGLoginService.h"

#import "SGLoginApi.h"
#import "SGLogoutApi.h"
#import "SGFindPwdApi.h"
#import "SGModifyPwdApi.h"

#import "SGUserModel.h"

@implementation SGLoginService

- (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
              logintType:(NSInteger)loginType
                 success:(void (^)(void))success
                 failure:(networkErrorBlock)failure {
    
    HTTPMSG_RELEASE_SAFELY(self.baseApi);
    
    if (self.noNetworkError && failure) {
        failure(self.noNetworkError);
        return;
    }
    
    self.baseApi = [[SGLoginApi alloc]initWithAccount:account password:password logintType:loginType];
    self.baseApi.baseApiProtocol = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        SGUserModel *userInfo = [[SGUserModel alloc]init];
        [[ZYCArchiveHelper sharedInstance] archiveObject:userInfo fileName:kSaveUserInfoModelName];
        if (success) {
            success();
        }
    });
//    [self.baseApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//        [self parseResponseData:request.responseJSONObject success:^(id json) {
//
//            SGUserModel *userInfo = [SGUserModel mj_objectWithKeyValues:json[@"student"]];
//            [[ZYCArchiveHelper sharedInstance] archiveObject:userInfo fileName:kSaveUserInfoModelName];
//            if (success) {
//                success();
//            }
//
//        } failure:^(NSError *error) {
//
//            if (failure) {
//                failure(error);
//            }
//
//        }];
//
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//        if (failure) {
//            failure([self showErrorInfo]);
//        }
//
//    }];
    
}

- (void)logOutSuccess:(void (^)(void))success failure:(networkErrorBlock)failure {
    
    HTTPMSG_RELEASE_SAFELY(self.baseApi);
    
    if (self.noNetworkError && failure) {
        failure(self.noNetworkError);
        return;
    }
    
    self.baseApi = [[SGLogoutApi alloc]init];
    self.baseApi.baseApiProtocol = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[ZYCArchiveHelper sharedInstance] deleteArchiveFileWithFileName:kSaveUserInfoModelName];
        if (success) {
            success();
        }
    });
    
//    [self.baseApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//        [self parseResponseData:request.responseJSONObject success:^(id json) {
//
//            [[ZYCArchiveHelper sharedInstance] deleteArchiveFileWithFileName:kSaveUserInfoModelName];
//            if (success) {
//                success();
//            }
//
//        } failure:^(NSError *error) {
//
//            if (failure) {
//                failure(error);
//            }
//
//        }];
//
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//        if (failure) {
//            failure([self showErrorInfo]);
//        }
//
//    }];
}

- (void)findPasswordWithPhone:(NSString *)phone
                      password:(NSString *)password
                       success:(void (^)(NSString *))success
                       failure:(networkErrorBlock)failure {
    
    HTTPMSG_RELEASE_SAFELY(self.baseApi);
    
    if (self.noNetworkError && failure) {
        failure(self.noNetworkError);
        return;
    }
    
    self.baseApi = [[SGFindPwdApi alloc]initWithPhone:phone password:password];
    self.baseApi.baseApiProtocol = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (success) {
            success(@"重置成功");
        }
    });
//    [self.baseApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//        [self parseResponseData:request.responseJSONObject success:^(id json) {
//
//            if (success) {
//                success(@"重置成功");
//            }
//
//        } failure:^(NSError *error) {
//
//            if (failure) {
//                failure(error);
//            }
//
//        }];
//
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//        if (failure) {
//            failure([self showErrorInfo]);
//        }
//
//    }];
}


- (void)modifyPwdWithOldPassword:(NSString *)oldPassword
                       nPassword:(NSString *)nPassword
                         success:(void (^)(NSString * _Nonnull))success
                         failure:(networkErrorBlock)failure {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (success) {
            success(@"修改成功");
        }
    });
    
//    HTTPMSG_RELEASE_SAFELY(self.baseApi);
//
//    if (self.noNetworkError && failure) {
//        failure(self.noNetworkError);
//        return;
//    }
//
//    self.baseApi = [[SGModifyPwdApi alloc]initWithOriginPwd:oldPassword nPassword:nPassword];
//    self.baseApi.baseApiProtocol = self;
//
//    [self.baseApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//        [self parseResponseData:request.responseJSONObject success:^(id json) {
//
//            if (success) {
//                success(@"修改成功");
//            }
//
//        } failure:^(NSError *error) {
//
//            if (failure) {
//                failure(error);
//            }
//
//        }];
//
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//        if (failure) {
//            failure([self showErrorInfo]);
//        }
//
//    }];
}

@end
