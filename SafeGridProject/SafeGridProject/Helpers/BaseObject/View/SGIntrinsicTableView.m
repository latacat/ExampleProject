//
//  SGIntrinsicTableView.m
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/12/20.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import "SGIntrinsicTableView.h"

@implementation SGIntrinsicTableView

- (void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize {
    [self layoutIfNeeded];
    return CGSizeMake(UIViewNoIntrinsicMetric, self.contentSize.height);
}

@end
