//
//  ZYCArchiveHelper.m
//  FilmsFans
//
//  Created by zhouyongchao on 16/1/27.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "ZYCArchiveHelper.h"

@interface ZYCArchiveHelper ()

@property (copy, nonatomic) NSString *documentPath;

@end

@implementation ZYCArchiveHelper
IMP_SINGLETON(ZYCArchiveHelper);

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _documentPath = [paths objectAtIndex:0];
    }
    return self;
}

- (BOOL)archiveObject:(id)saveObject fileName:(NSString *)fileName {
    NSString *path = [self.documentPath stringByAppendingPathComponent:fileName];
    BOOL success = [NSKeyedArchiver archiveRootObject:saveObject toFile:path];
    return success;
}

- (id)unArchiveObjectWithFileName:(NSString *)fileName {
    NSString *path = [self.documentPath stringByAppendingPathComponent:fileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (void)deleteArchiveFileWithFileName:(NSString *)fileName {
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSString *path = [self.documentPath stringByAppendingPathComponent:fileName];
    if ([defaultManager isDeletableFileAtPath:path]) {
        [defaultManager removeItemAtPath:path error:NULL];
    }
}

@end
