//
//  Migration.h
//  JingHuaTimes
//
//  Created by 周永超 on 2017/5/25.
//  Copyright © 2017年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDBMigrationManager/FMDBMigrationManager.h>

@interface Migration : NSObject<FMDBMigrating>

- (instancetype)initWithName:(NSString *)name
                     version:(uint64_t)version
          executeUpdateArray:(NSArray *)sqlArr;

@end
