//
//  UIButton+EnlargeEdge.h
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/3/30.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeEdge)

/** 设置可点击范围到按钮边缘的距离 */
- (void)setEnlargeEdge:(CGFloat)size;

/** 设置可点击范围到按钮上、右、下、左的距离 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end
