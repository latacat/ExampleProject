//
//  ZYCEmptyDataSetController.m
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/5/12.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "ZYCEmptyDataSetController.h"

@interface ZYCEmptyDataSetController ()

@end

@implementation ZYCEmptyDataSetController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (BaseEmptyDataSet *)emptyDataSet {
    
    if (!_emptyDataSet) {
        _emptyDataSet = [[BaseEmptyDataSet alloc]init];
    }
    return _emptyDataSet;
}

@end
