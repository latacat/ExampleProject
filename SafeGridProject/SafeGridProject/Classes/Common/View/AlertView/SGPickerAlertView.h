//
//  SGPickerAlertView.h
//  SafeGridProject
//
//  Created by zhongda on 2019/1/22.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SGPickerAlertViewProtocol.h"

/**
 使用示例：
 1.新建模型实现SGPickerAlertViewProtocol协议，属性名字可自定义
 
 .h 文件内容如下：
 #import <Foundation/Foundation.h>
 
 #import "SGPickerAlertViewProtocol.h"
 
 @interface SGTestPickerAlertModel : NSObject<SGPickerAlertViewProtocol>
 
 @property (nonatomic, nullable, copy) NSString *content;
 
 @property (nonatomic, nullable, copy) NSString *contentId;
 
 @end
 
 .m 内容如下:
 #import "SGTestPickerAlertModel.h"
 
 @implementation SGTestPickerAlertModel
 
 - (NSString *)pickerAlertViewRowId {
 return self.contentId;
 }
 
 - (NSString *)pickerAlertViewRowContent {
 return self.content;
 }
 
 @end
 
 2.在需要显示弹框的地方调用
 
 NSMutableArray *tempArr = [NSMutableArray array];
 for (NSInteger i = 0; i < 10; i++) {
 
 SGTestPickerAlertModel *testModel = [[SGTestPickerAlertModel alloc]init];
 testModel.contentId = @(i).stringValue;
 testModel.content = @(i).stringValue;
 [tempArr addObject:testModel];
 }
 [SGPickerAlertView showPickerAlertViewWithContentArr:tempArr cancelClickBlock:nil sureClickBlock:^(UIButton * _Nonnull sender, NSString * _Nonnull selectedId) {
 
    NSLog(@"%@",selected);
 }];
 
 */
@interface SGPickerAlertView : UIView

@property (nonatomic, copy) void(^leftButtonClickedBlock)(UIButton *sender);

@property (nonatomic, copy) void(^rightButtonClickedBlock)(UIButton *sender, NSString *selectedId);

+ (SGPickerAlertView *)shareInstance;

+ (instancetype)showPickerAlertViewWithContentArr:(nullable NSArray<id<SGPickerAlertViewProtocol>> *)contentArr
                                 cancelClickBlock:(void(^)(UIButton *sender))leftBlock
                                   sureClickBlock:(void(^)(UIButton *sender, NSString *selectedId))rightBlock;

@end
