//
//  DeviceUUID.h
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/31.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DeviceUUID : NSObject

DEF_SINGLETON(DeviceUUID)

+ (NSString *)takeDeviceUUID;

- (BOOL)isIPhoneXOrAfter;

@end
