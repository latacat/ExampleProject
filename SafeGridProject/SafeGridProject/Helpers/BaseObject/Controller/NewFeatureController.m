//
//  NewFeatureController.m
//  JingHuaTimes
//
//  Created by zhouyongchao on 16/1/26.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "NewFeatureController.h"

static NSInteger const DEFAULT_COUNT = 4;
@interface NewFeatureController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *btnStart;

@end

@implementation NewFeatureController

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.scrollView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImages];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *DEFAULT_COUNT, SCREEN_HEIGHT);
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_scrollView);
    _ZYCBasicBlock = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - system delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > 40) {
        scrollView.bounces = YES;
    } else {
        scrollView.bounces = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat space = scrollView.contentOffset.x - SCREEN_WIDTH * (DEFAULT_COUNT - 1);
    if (space > 30) {
        [self dismissAnimation];
    }
}

#pragma mark - private method

- (void)clickImmediateAction:(UIButton *)sender {
    [self dismissAnimation];
}

- (void)dismissAnimation {
    
    [UIView animateWithDuration:0.4 delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(-SCREEN_WIDTH, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            [self dismiss];
        }
    }];
}

#pragma mark - public methods
- (void)showNewFeatureToWindow:(UIWindow *)window {
    [window addSubview:self.view];
}

#pragma mark - private methods
- (void)addImages {
    @autoreleasepool {
        for (int i = 0; i < DEFAULT_COUNT; i++) {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            if (BJOP_IS_IPHONE_X) {
                imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"NEWHELPER_IPHONEX_%d",i+1]];
            } else {
                imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"NEWHELPER_%d",i+1]];
            }
            
            [self.scrollView addSubview:imageV];
            TT_RELEASE_SAFELY(imageV);
            
            if (i == DEFAULT_COUNT - 1) {
                
                if (BJOP_IS_IPHONE_X) {
                    
                    self.btnStart.frame = CGRectMake(i * SCREEN_WIDTH + 120.f * SCREEN_WIDTH / 375.f, SCREEN_HEIGHT - 134 * SCREEN_WIDTH / 375.f - 30.f * SCREEN_WIDTH / 375.f, 132.f * SCREEN_WIDTH / 375.f, 30.f * SCREEN_WIDTH / 375.f);
                    
                } else {
                    
                    self.btnStart.frame = CGRectMake(i * SCREEN_WIDTH + 120.f * SCREEN_WIDTH / 375.f, SCREEN_HEIGHT - 110 * SCREEN_WIDTH / 375.f, 132 * SCREEN_WIDTH / 375.f, 30.f * SCREEN_WIDTH / 375.f);
                    
                }
                
                [self.scrollView addSubview:self.btnStart];
            }
        }
    }
}

- (void)dismiss {
    [self.view removeFromSuperview];
    if (self.ZYCBasicBlock) {
        self.ZYCBasicBlock();
    }
}

#pragma mark - setter
- (void)setZYCBasicBlock:(void (^)(void))ZYCBasicBlock {
    _ZYCBasicBlock = ZYCBasicBlock;
}

#pragma mark - getters
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator= NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}

- (UIButton *)btnStart {
    
    if (!_btnStart) {
        _btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnStart.backgroundColor = [UIColor clearColor];
        [_btnStart addTarget:self action:@selector(clickImmediateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnStart;
}

@end
