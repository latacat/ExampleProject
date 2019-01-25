//
//  SNBaseApi.h
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/27.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "UrlConstant.h"
#import <MJExtension/NSObject+MJKeyValue.h>
#import "NSString+AES.h"
#import "NSString+RSA.h"
#import "SGUserDAO.h"

@protocol SGBaseApiProtocol<NSObject>

- (NSDictionary *)requestHeaderFieldValue;

@end

static NSString *const KEY_ENCRYPT_DATA = @"params";

@interface SGBaseApi : YTKRequest

@property (nonatomic, weak) id<SGBaseApiProtocol> baseApiProtocol;

- (void)setSecretParams:(NSDictionary *)secretParams inParmas:(NSMutableDictionary *)originParams;
   
@end
