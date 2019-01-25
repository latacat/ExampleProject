//
//  DataBaseManager.m
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/29.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "DataBaseManager.h"

static NSString *const DataBaseFileName = @"SNTDataBase.sqlite3";

@interface DataBaseManager ()

@end

@implementation DataBaseManager

+ (DataBaseManager *)shareInstance {
    static dispatch_once_t onceToken;
    static DataBaseManager *singleton;
    dispatch_once(&onceToken, ^{
        singleton = [[[self class] alloc]init];
    });
    return singleton;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataBasePath = [[self createDataBaseDirectory] stringByAppendingString:DataBaseFileName];
        _dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:_dataBasePath];
    }
    return self;
}

#pragma mark - private method

- (NSString *)createDataBaseDirectory {
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    cacheDirectory = [[cacheDirectory stringByAppendingPathComponent:@"NespaperTeacherDatabase"]copy];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = YES;
    BOOL isExist = [fileManager fileExistsAtPath:cacheDirectory isDirectory:&isDirectory];
    if (!isExist) {
        [fileManager createDirectoryAtPath:cacheDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return cacheDirectory;
}

@end
