//
//  SNHttpBaseModel.h
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/1/29.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

@interface HttpBaseModel : NSObject

@property (nonatomic, copy) NSString *errorCode;
@property (nonatomic, copy) NSString *errorMsg;
@property (nonatomic, strong) id responseData;
@property (nonatomic, assign) NSInteger dataType;
           
@end
