//
//  NSString+ZYCExtension.m
//  BeijingOpenUniversity
//
//  Created by 周永超 on 2018/12/25.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import "NSString+ZYCExtension.h"

@implementation NSString (ZYCExtension)

- (NSArray *)zyc_separateStringToArray {
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = 0; i < self.length; i++) {
        NSRange range;
        range.location = i;
        range.length = 1;
        
        NSString *tempString = [self substringWithRange:range];
        [tempArr addObject:tempString];
    }
    return tempArr;
}

@end
