//
//  DataBaseDAO.h
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/29.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseDAO : NSObject

+ (DataBaseDAO *)shareInstance;

@property (nonatomic, assign) BOOL tableIsCreated;

- (void)createTablesIfNeeded;

@end
