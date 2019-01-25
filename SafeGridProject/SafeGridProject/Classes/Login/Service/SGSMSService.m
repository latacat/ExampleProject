//
//  SGSMSService.m
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGSMSService.h"
#import "SGSendSMSApi.h"

@implementation SGSMSService

- (void)sendSMSWithTypeName:(NSString *)typeName
                   phoenNum:(NSString *)phoneNum
                   sendType:(NSInteger)type
                    success:(nonnull void (^)(NSString *))success
                    failure:(networkErrorBlock)failure {
    
    HTTPMSG_RELEASE_SAFELY(self.baseApi);
    
    if (self.noNetworkError && failure) {
        failure(self.noNetworkError);
        return;
    }
    
    self.baseApi = [[SGSendSMSApi alloc]initWithTypeName:typeName phoenNum:phoneNum sendType:type];
    self.baseApi.baseApiProtocol = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (success) {
            success(@"发送成功");
        }
    });
    
//    [self.baseApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//        [self parseResponseData:request.responseJSONObject success:^(id json) {
//
//            if (success) {
//                success(@"发送成功");
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
