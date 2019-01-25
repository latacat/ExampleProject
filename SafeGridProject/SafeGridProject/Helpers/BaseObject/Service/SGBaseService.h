//
//  SNBaseService.h
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/27.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
#import "SGBaseApi.h"
#import "GlobalMacro.h"
#import "SGUserDAO.h"


typedef void(^ _Nullable networkErrorBlock)(NSError * _Nullable error);

@interface SGBaseService : NSObject <SGBaseApiProtocol>

@property (nonatomic, strong) SGBaseApi *baseApi;

@property (nonatomic, strong) NSError *noNetworkError;

- (void)parseResponseData:(id)responseData
                  success:(void(^)(id json))success
                  failure:(void(^)(NSError *error))failure;



- (NSError *)showErrorInfo;

- (NSError *)showErrorInfoWithMsg:(NSString *)message;

- (NSError *)showErrorInfoWithMsg:(NSString *)message code:(NSInteger)errorCode;

@end
