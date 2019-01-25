//
//  SNBaseEmptyDataSet.h
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/5/12.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EmptyDataSetType) {
    EmptyDataSetTypeNone,
    EmptyDataSetTypeNoData,
    EmptyDataSetTypeQuestionAnswerNoData,
    EmptyDataSetTypeNoNetwork,
};

@import DZNEmptyDataSet;

@interface BaseEmptyDataSet : NSObject<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, nullable, strong) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL hidePlacHolderImage;

@property (nonatomic, assign) CGFloat verticalOffset;

@property (nonatomic, assign) EmptyDataSetType emptyDataType;

@property (nonatomic, nullable, copy) NSString *tipsTitle;

@property (nonatomic, assign) BOOL isRequesting;//正在请求数据

@property (nonatomic, assign) BOOL showTapButton;

@property (nonatomic, copy) void(^ _Nullable didTapEmptyViewButton)(EmptyDataSetType dataSetType);

@end
