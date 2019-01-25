//
//  CommonTools.h
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/31.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonTools : NSObject

+ (CommonTools *)shareInstance;

- (BOOL)isMobileNumber:(NSString *)mobileNum;

- (BOOL)isLegalPassword:(NSString *)password;

@end
