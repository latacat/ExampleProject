//
//  UITableView+SNRefresh.h
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/2/1.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@interface UITableView (SNRefresh)

@property (nonatomic, assign) NSInteger currentPage;

- (void)zyc_setupRefreshViewInController:(UIViewController *)refreshController hasHeaderRefresh:(BOOL)headerRefresh hasFooterRefresh:(BOOL)footRefresh;

- (void)setNeedMore:(BOOL)needMore;

- (void)endRefreshingState;

@end
