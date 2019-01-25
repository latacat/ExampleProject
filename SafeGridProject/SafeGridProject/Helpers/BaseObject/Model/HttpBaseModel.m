//
//  SNHttpBaseModel.m
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/29.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "HttpBaseModel.h"

@implementation HttpBaseModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"errorCode" : @"code",
             @"errorMsg" : @"message",
             @"responseData": @"data"
             };
}

@end
