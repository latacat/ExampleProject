//
//  URLUtil.h
//  Zhuntiku
//
//  Created by LXZ on 16/7/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLUtil : NSObject

+ (NSArray *)getURLMatchesAtString:(NSString *)string;
+ (BOOL)isContentURLAtString:(NSString *)string;
+ (NSArray *)getURLArrayAtString:(NSString *)string;

@end
