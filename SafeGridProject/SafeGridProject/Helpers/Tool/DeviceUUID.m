//
//  DeviceUUID.m
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/31.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "DeviceUUID.h"
#import <SAMKeychain/SAMKeychain.h>
#import "sys/utsname.h"

static NSString *const UUIDServiceName = @"com.zhongdayingcai.BeijingOpenUniversity";
static NSString *const UUIDAccount = @"BJOUUUIDAccount";

@implementation DeviceUUID

IMP_SINGLETON(DeviceUUID)

+ (NSString *)takeDeviceUUID {
    
    NSString *uuid = [SAMKeychain passwordForService:UUIDServiceName account:UUIDAccount];
    if (uuid && uuid.length > 0) {
        return uuid;
    } else {
        CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
        NSString *cfuuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,cfuuid));
        
        [SAMKeychain setPassword:cfuuidString forService:UUIDServiceName account:UUIDAccount];
        
        return cfuuidString;
    }
}

- (BOOL)isIPhoneXOrAfter {
    
    NSString *version = [self deviceVersion];
    if ([version isEqualToString:@"Simulator"]) {
        
        BOOL isIPhoneXOrXS = (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)) ||
                              CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)));
        
        BOOL isIPhoneXSMaxOrXR = (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 896)) ||
                                  CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(896, 414)));
        
        return isIPhoneXOrXS || isIPhoneXSMaxOrXR;
        
    } else if ([version isEqualToString:@"iPhone X"] || [version isEqualToString:@"iPhone XR"] || [version isEqualToString:@"iPhone XS"] || [version isEqualToString:@"iPhone XS Max"]) {
        return YES;
    }
    
    return NO;
}

- (NSString*)deviceVersion {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"i386"] || [deviceString isEqualToString:@"x86_64"]) {
        return @"Simulator";
    }
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone9,1"] || [deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"] || [deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"] || [deviceString isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"] || [deviceString isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"] || [deviceString isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,4"] || [deviceString isEqualToString:@"iPhone11,6"])    return @"iPhone XS Max";
    return deviceString;
}

@end
