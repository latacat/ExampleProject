//
//  SGPickerAlertViewProtocol.h
//  SafeGridProject
//
//  Created by zhongda on 2019/1/23.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SGPickerAlertViewProtocol <NSObject>

/**
 当前pickerView每行的内容

 @return 每行内容
 */
- (NSString *)pickerAlertViewRowContent;

/**
 当前pickerView每行id

 @return 每行id
 */
- (NSString *)pickerAlertViewRowId;

@end

