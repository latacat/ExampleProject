//
//  Migration.m
//  JingHuaTimes
//
//  Created by 周永超 on 2017/5/25.
//  Copyright © 2017年 zhouyongchao. All rights reserved.
//

#import "Migration.h"

@interface Migration ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) uint64_t version;
@property (nonatomic, strong) NSArray *sqlArr;

@end

@implementation Migration

- (instancetype)initWithName:(NSString *)name version:(uint64_t)version executeUpdateArray:(NSArray *)sqlArr {
    
    self = [super init];
    if (self) {
        _name = name;
        _version = version;
        _sqlArr = sqlArr;
    }
    return self;
    
}

- (NSString *)name {
    return _name;
}

- (uint64_t)version {
    return _version;
}

- (BOOL)migrateDatabase:(FMDatabase *)database error:(out NSError *__autoreleasing *)error {
    
    for (NSString *sql in _sqlArr) {
        [database executeUpdate:sql];
    }
    
    return YES;
}

@end
