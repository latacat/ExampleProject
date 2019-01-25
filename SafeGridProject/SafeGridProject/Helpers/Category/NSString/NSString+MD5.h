//
//  NSString+MD5.h
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/29.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MD5)

+ (NSString *)md5StringFromString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
