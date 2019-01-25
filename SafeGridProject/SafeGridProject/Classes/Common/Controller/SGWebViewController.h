//
//  SNWebViewController.h
//  StudyNewspaperStudent
//
//  Created by zhongda on 2018/6/7.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "ZYCBaseViewController.h"

@interface SGWebViewController : ZYCBaseViewController

@property (nonatomic, copy) NSString *linkUrl;
@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, assign) BOOL hideRightButton;

/**
 初始化方法
 
 @param url 链接地址
 @param itemTitle 控制器标题
 @return 控制器实例
 */
- (instancetype)initWithUrl:(NSString *)url
                      title:(NSString *)itemTitle;

@end
