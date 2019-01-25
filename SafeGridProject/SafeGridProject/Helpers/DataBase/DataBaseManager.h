//
//  DataBaseManager.h
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/29.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

@interface DataBaseManager : NSObject

@property (nonatomic, copy) NSString *dataBasePath;
@property (nonatomic, strong) FMDatabaseQueue *dataBaseQueue;

+ (DataBaseManager *)shareInstance;

@end
