//
//  SNBaseEmptyDataSet.m
//  StudyNewspaperTeacher
//
//  Created by zhongda on 2018/5/12.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "BaseEmptyDataSet.h"
//#import "ZYCTabBarMacro.h"

@interface BaseEmptyDataSet ()

@end

@implementation BaseEmptyDataSet

@synthesize verticalOffset = _verticalOffset;

- (instancetype)init {
    self = [super init];
    if (self) {
        _showTapButton = NO;
    }
    return self;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"";
    UIFont *font = [UIFont systemFontOfSize:16.f];
    UIColor *textColor = COLOR_WITH_HEX(0x666666);
    
    switch (self.emptyDataType) {
        case EmptyDataSetTypeNoData:
        {
            text = self.tipsTitle ?: @"暂无数据";
            font = [UIFont systemFontOfSize:15.f];
        }
            break;
        case EmptyDataSetTypeQuestionAnswerNoData:
        {
            text = @"暂无相关内容";
            font = [UIFont systemFontOfSize:15.f];
        }
            break;
        case EmptyDataSetTypeNoNetwork:
        {
            text = @"网络不给力哦，请检查你的网络设置";
            font = [UIFont systemFontOfSize:15.f];
        }
            break;
        default:
            break;
    }
    return [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor}];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *imageName = nil;
    
    switch (self.emptyDataType) {
        case EmptyDataSetTypeNoData:
            imageName = @"home_no";
            break;
        case EmptyDataSetTypeQuestionAnswerNoData:
            imageName = @"icon_no_question";
            break;
        case EmptyDataSetTypeNoNetwork:
            imageName = @"icon_no_network";
            break;
        default:
            break;
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    if (!self.showTapButton) {
        return nil;
    }
    
    NSString *text = @"";
    UIFont *font = [UIFont systemFontOfSize:16.f];
    UIColor *textColor = [UIColor whiteColor];
    switch (self.emptyDataType) {
        case EmptyDataSetTypeNoData:
        {
            text = @"点击刷新";
            textColor = [UIColor whiteColor];
        }
            break;
        case EmptyDataSetTypeNoNetwork:
        {
            text = @"重新加载";
//            textColor = (state == UIControlStateNormal) ? COLORFROMHEX(0x999999) : COLORFROMHEX(0xebebeb);
            textColor = [UIColor whiteColor];
        }
            break;
        default:
            break;
    }
    
    return [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor}];
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    if (!self.showTapButton) {
        return nil;
    }
    
//    NSString *imageName = [[NSString stringWithFormat:@"button_background_%@", @"icloud"] lowercaseString];
//
//    if (state == UIControlStateNormal) imageName = [imageName stringByAppendingString:@"_normal"];
//    if (state == UIControlStateHighlighted) imageName = [imageName stringByAppendingString:@"_highlight"];
    NSString *imageName = @"icon_round_rect";
    
    UIEdgeInsets capInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    UIEdgeInsets rectInsets = UIEdgeInsetsZero;

    switch (self.emptyDataType) {
        case EmptyDataSetTypeNoNetwork:
            rectInsets = UIEdgeInsetsMake(8.0, -100.0 * SCREEN_WIDTH / 375.f, 8, -100.0 * SCREEN_WIDTH / 375.f);
            break;
        case EmptyDataSetTypeNoData:
            rectInsets = UIEdgeInsetsMake(8.0, -100.0 * SCREEN_WIDTH / 375.f, 8, -100.0 * SCREEN_WIDTH / 375.f);
            break;
        default:
            break;
    }

    UIImage *image = [UIImage imageNamed:imageName inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];

    return [[image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    
    switch (self.emptyDataType) {
        case EmptyDataSetTypeNoNetwork:
            return BGGrayColor;
            break;
        case EmptyDataSetTypeNoData:
            return BGGrayColor;
            break;
        default:
            break;
    }
    return BGGrayColor;
}

#pragma mark - emptyDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return !self.isRequesting;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    
    return self.verticalOffset;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    
    if (self.didTapEmptyViewButton) {
        self.didTapEmptyViewButton(self.emptyDataType);
    }
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    
    [UIView animateWithDuration:0.5 animations:^{
        scrollView.contentOffset = CGPointZero;
    }];
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    
    if (self.emptyDataType == EmptyDataSetTypeNoNetwork) {
        return 30.f;
    }
    return 0.f;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

#pragma mark - private method

- (void)resetConfig {
    
    _emptyDataType = EmptyDataSetTypeNoData;
}

#pragma mark - setter

- (void)setScrollView:(UIScrollView *)scrollView {
    
    _scrollView = scrollView;
    scrollView.emptyDataSetSource = self;
    scrollView.emptyDataSetDelegate = self;
}

- (void)setTipsTitle:(NSString *)tipsTitle {
    
    _tipsTitle = [tipsTitle copy];
    [self.scrollView reloadEmptyDataSet];
}

- (void)setEmptyDataType:(EmptyDataSetType)emptyDataType {
    
    if (_emptyDataType == emptyDataType) {
        return;
    }
    _emptyDataType = emptyDataType;
    
    if (emptyDataType == EmptyDataSetTypeNoNetwork) {
        self.showTapButton = YES;
    } else {
        self.showTapButton = NO;
    }
    
    [self.scrollView reloadEmptyDataSet];
}

- (void)setIsRequesting:(BOOL)isRequesting {
    
    [self resetConfig];//解决以下场景问题 第一次加载失败 emptyStyle = nonetowrk 重新加载以后style没变，当数据为空时，显示的还是无网络的style
    if (_isRequesting == isRequesting) {
        return;
    }
    _isRequesting = isRequesting;
    
    [self.scrollView reloadEmptyDataSet];
}

- (void)setShowTapButton:(BOOL)showTapButton {
    
    if (_showTapButton == showTapButton) {
        return;
    }
    
    _showTapButton = showTapButton;
    
    [self.scrollView reloadEmptyDataSet];
}

- (void)setVerticalOffset:(CGFloat)verticalOffset {
    _verticalOffset = verticalOffset;
    [self.scrollView reloadEmptyDataSet];
}

- (void)setHidePlacHolderImage:(BOOL)hidePlacHolderImage {
    _hidePlacHolderImage = hidePlacHolderImage;
    self.scrollView.hidden = hidePlacHolderImage;
}

#pragma mark - getter

- (CGFloat)verticalOffset {
    
    if (!_verticalOffset) {
        if (BJOP_IS_IPHONE_X) {
            return -88.f;
        }
        return -44.f;
    }
    return _verticalOffset;
}

@end
