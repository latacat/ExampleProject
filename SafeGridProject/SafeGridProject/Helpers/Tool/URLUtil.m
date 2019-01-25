//
//  URLUtil.m
//  Zhuntiku
//
//  Created by LXZ on 16/7/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "URLUtil.h"

@implementation URLUtil

+ (BOOL)isContentURLAtString:(NSString *)string{

    return [[self getURLMatchesAtString:string] count]==0?NO:YES;
}

+ (NSArray *)getURLArrayAtString:(NSString *)string{
    
    NSArray *matches = [self getURLMatchesAtString:string];
    
    NSMutableArray *urlArray = [NSMutableArray array];
    for (NSTextCheckingResult *result in matches) {
        
        [urlArray addObject:result.URL];
    }
    
    return urlArray;
}

+ (NSArray *)getURLMatchesAtString:(NSString *)string{
    
    NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [detector matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    return matches;
}

@end
