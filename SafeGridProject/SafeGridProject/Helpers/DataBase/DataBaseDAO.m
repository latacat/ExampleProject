//
//  DataBaseDAO.m
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/29.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "DataBaseDAO.h"
#import <FMDBMigrationManager/FMDBMigrationManager.h>
#import "DataBaseManager.h"
#import "Migration.h"

@implementation DataBaseDAO

+ (DataBaseDAO *)shareInstance {
    static dispatch_once_t onceToken;
    static DataBaseDAO *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[DataBaseDAO alloc]init];
    });
    return instance;
}

- (void)createTablesIfNeeded {
    
    FMDBMigrationManager *manager = [FMDBMigrationManager managerWithDatabaseAtPath:[DataBaseManager shareInstance].dataBasePath migrationsBundle:[NSBundle mainBundle]];
    Migration *v1 = [[Migration alloc]initWithName:@"初始化表结构" version:1 executeUpdateArray:@[
                                                                                            @"create table if not exists snt_secret(id INTEGER PRIMARY KEY UNIQUE NOT NULL, aes_key TEXT)",
                                                                                            @"create table if not exists snt_user(id INTEGER PRIMARY KEY UNIQUE NOT NULL,\
                                                                                            user_id TEXT,\
                                                                                            password_type INTEGER,\
                                                                                            realName TEXT,\
                                                                                            userName TEXT,\
                                                                                            gender INTEGER,\
                                                                                            headImageUrl TEXT,\
                                                                                            is_login INTEGER)"]];
    [manager addMigration:v1];
    
    BOOL resultState = NO;
    NSError *error = nil;
    if (!manager.hasMigrationsTable) {
        resultState = [manager createMigrationsTable:&error];
    }
    resultState = [manager migrateDatabaseToVersion:UINT64_MAX progress:nil error:&error];
    if (error) {
        NSLog(@"数据库初始化失败");
    } else {
        self.tableIsCreated = YES;
    }
}

@end
