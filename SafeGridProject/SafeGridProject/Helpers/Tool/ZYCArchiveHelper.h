//
//  ZYCArchiveHelper.h
//  FilmsFans
//
//  Created by zhouyongchao on 16/1/27.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalMacro.h"

@interface ZYCArchiveHelper : NSObject
DEF_SINGLETON(ZYCArchiveHelper);
/**
 *  归档
 *
 *  @param saveObject 要归档的对象
 *  @param fileName   归档名称
 */
- (BOOL)archiveObject:(id)saveObject fileName:(NSString *)fileName;
/**
 *  解档
 *
 *  @param fileName 要解档的文件名称
 */
- (id)unArchiveObjectWithFileName:(NSString *)fileName;
/**
 *  删除归档文件
 *
 *  @param fileName 归档文件名称
 */
- (void)deleteArchiveFileWithFileName:(NSString *)fileName;
@end
