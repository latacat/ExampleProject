//
//  UITableView+SNRefresh.m
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/2/1.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "UITableView+SNRefresh.h"
#import "WeakAndStrongDefine.h"
#import <objc/runtime.h>

@implementation UITableView (SNRefresh)

- (void)zyc_setupRefreshViewInController:(UIViewController *)refreshController hasHeaderRefresh:(BOOL)headerRefresh hasFooterRefresh:(BOOL)footRefresh {
    
    @weakify(refreshController)
    if (headerRefresh) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(refreshController)
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [refreshController performSelector:NSSelectorFromString(@"SN_loadLastData")];
#pragma clang diagnostic pop
        }];
    }
    
    if (footRefresh) {
        
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(refreshController)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [refreshController performSelector:NSSelectorFromString(@"SN_loadMoreData")];
#pragma clang diagnostic pop
        }];
//        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            @strongify(refreshController)
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//            [refreshController performSelector:NSSelectorFromString(@"SN_loadMoreData")];
//#pragma clang diagnostic pop
//        }];
    }
}

- (void)setNeedMore:(BOOL)needMore {
    if (!needMore) {
        [self.mj_footer endRefreshingWithNoMoreData];
    } else {
        self.currentPage += 1;
    }
}

- (void)endRefreshingState {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    objc_setAssociatedObject(self, @selector(currentPage), @(currentPage), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)currentPage {
    NSNumber *number = objc_getAssociatedObject(self, @selector(currentPage));
    return [number integerValue];
}

@end
