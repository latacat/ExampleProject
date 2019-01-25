//
//  ZYCBaseViewController.m
//  JHNews
//
//  Created by 周永超 on 2017/4/20.
//  Copyright © 2017年 xiaozhang. All rights reserved.
//

#import "ZYCBaseViewController.h"
#import "NSString+Height.h"
#import "UINavigationController+StatusBarStyle.h"

#define COLORFROMHEX(hexValue)    [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define kBackButtonWidth 44.f

static NSString * const kNavBarImageName = @"nav_background_image";

@interface ZYCBaseViewController ()

@property (nonatomic, strong) UIView        *statusBarView;
@property (nonatomic, strong) UIView        *navigationView;
@property (nonatomic, nullable, strong) UIImageView *statusBarImageView;
@property (nonatomic, strong) UIImageView   *navigationImageView;
@property (nonatomic, strong) UIView        *bottomLine;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *detailLabel;
@property (nonatomic, strong) UIButton      *leftButton;
@property (nonatomic, strong) UIButton      *rightButton;

@property (nonatomic, assign) CGFloat statusBarHeight;
@property (nonatomic, assign) CGFloat navBarHeight;
@property (nonatomic, assign) CGFloat tabBarHeight;

@end

@implementation ZYCBaseViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _showNav = YES;
        _showBottomLine = NO;
        _showShadowImage = NO;
        _showNavBarImage = YES;
        _isPresented = NO;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _showNav = YES;
        _showBottomLine = NO;
        _showShadowImage = NO;
        _showNavBarImage = YES;
        _isPresented = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (BJOP_IS_IPHONE_X) {
        _tabBarHeight = 83.f;
    } else {
        _tabBarHeight = 49.f;
    }
    [self p_congfigure];
    [self setupNavView];
    [self setupEmptyDataSet];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.shadowImageV];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.view bringSubviewToFront:self.statusBarView];
    [self.view bringSubviewToFront:self.navigationView];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat height =  [self heightForNavigationView];
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeAreaInsets = UIEdgeInsetsMake(NavStatusBar_Height, 0, 0, 0);
        self.statusBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, safeAreaInsets.top);
//        self.statusBarImageView.frame = self.statusBarView.bounds;
        self.navigationView.frame = CGRectMake(0, safeAreaInsets.top, [UIScreen mainScreen].bounds.size.width, height);
        self.navigationImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, safeAreaInsets.top + height);
        self.bottomLine.frame = CGRectMake(0, height - 1/[UIScreen mainScreen].scale, [UIScreen mainScreen].bounds.size.width, 1 / [UIScreen mainScreen].scale);
        self.navBarHeight = height + safeAreaInsets.top;
        self.statusBarHeight = safeAreaInsets.top;
    } else {
        self.statusBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20.f);
//        self.statusBarImageView.frame = self.statusBarView.bounds;
        self.navigationView.frame = CGRectMake(0, 20.f, [UIScreen mainScreen].bounds.size.width, height);
        self.navigationImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height + 20.f);
        self.bottomLine.frame = CGRectMake(0, height - 1 / [UIScreen mainScreen].scale, [UIScreen mainScreen].bounds.size.width, 1 / [UIScreen mainScreen].scale);
        self.navBarHeight = height + 20.f;
        self.statusBarHeight = 20.f;
    }
    
    self.shadowImageV.frame = CGRectMake(0, self.navBarHeight, [UIScreen mainScreen].bounds.size.width, 10.f);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - private method

- (void)p_congfigure {
    [self.view addSubview:self.statusBarView];
    [self.view addSubview:self.navigationView];
    
//    [self.statusBarView addSubview:self.statusBarImageView];
    [self.view addSubview:self.navigationImageView];
    
    if (!_showShadowImage && _showBottomLine) {
        [self.navigationView addSubview:self.bottomLine];
    }
    if (!_showBottomLine && _showShadowImage) {

        [self.view addSubview:self.shadowImageV];
    }
    
    self.bottomLine.backgroundColor = [UIColor lightGrayColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    self.detailLabel.textColor = [UIColor whiteColor];
    self.detailLabel.backgroundColor = [UIColor clearColor];
    self.detailLabel.font = [UIFont systemFontOfSize:12.f];
    
    self.leftButton.contentMode = UIViewContentModeRight;
    [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted | UIControlStateSelected];
    
    self.rightButton.contentMode = UIViewContentModeLeft;
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted | UIControlStateSelected];
    
}

- (CGFloat)heightForNavigationView {
//    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
//    CGFloat height =  orientation == (UIDeviceOrientationPortrait) ? 44.f : 32.f;
//    return height;
    
    if (self.detailText && ![self.detailText isEqualToString:@""]) {
        return 49.f;
    }
    return 44.f;
}

#pragma mark - public method

- (void)createNavigationBarWithTitle:(__kindof NSString *)title {
    
    self.titleLabel.text = title;
    CGFloat labelWidth = [self.titleLabel.text zyc_widthForFont:self.titleLabel.font];
    CGFloat labelHeight = [self.titleLabel.text zyc_heightForFont:self.titleLabel.font width:labelWidth];
    
    if (labelWidth > SCREEN_WIDTH - 100.f) {
        labelWidth = SCREEN_WIDTH - 100.f;
    }
    
    CGFloat height =  [self heightForNavigationView];
    self.titleLabel.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - labelWidth) / 2, (height - labelHeight) / 2, labelWidth, labelHeight);
    
    [self.navigationView addSubview:self.titleLabel];
}

- (void)createNavigationBarWithTitle:(__kindof NSString *)title backgroundImageName:(NSString *)imageName {
    
    self.navigationImageView.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = title;
    
    CGFloat labelWidth = [self.titleLabel.text zyc_widthForFont:self.titleLabel.font];
    CGFloat labelHeight = [self.titleLabel.text zyc_heightForFont:self.titleLabel.font width:labelWidth];
    
    CGFloat height =  [self heightForNavigationView];
    self.titleLabel.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - labelWidth) / 2, (height - labelHeight) / 2, labelWidth, labelHeight);
    
    [self.navigationView addSubview:self.titleLabel];
    
}

- (void)createNavigationBarWithDetailTitle:(__kindof NSString *)title {
    
    self.detailText = title;
}

- (void)createNavigationBarWithTitleView:(UIView *)titleView {
    
    CGFloat viewWidth = titleView.frame.size.width < [UIScreen mainScreen].bounds.size.width ? titleView.frame.size.width : [UIScreen mainScreen].bounds.size.width;
    CGFloat viewHeight = titleView.frame.size.height < 44.f ? titleView.frame.size.height : 44.f;
    CGFloat height =  [self heightForNavigationView];
    
    titleView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - viewWidth) / 2,  (height - viewHeight) / 2, viewWidth, viewHeight);
    
    [self.navigationView addSubview:titleView];
    
}

- (void)createNavigationBarWithTitleView:(UIView *)titleView
                     backgroundImageName:(NSString *)imageName {
    
    if (!imageName) {
        imageName = @"nav_background_image";
    }
    self.navigationImageView.image = [UIImage imageNamed:imageName];
    
    CGFloat viewWidth = titleView.frame.size.width < [UIScreen mainScreen].bounds.size.width - 100 ? titleView.frame.size.width : [UIScreen mainScreen].bounds.size.width - 100;
    CGFloat viewHeight = titleView.frame.size.height < 44.f ? titleView.frame.size.height : 44.f;
    CGFloat height =  [self heightForNavigationView];
    
    titleView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - viewWidth) / 2, (height - viewHeight) / 2, viewWidth, viewHeight);
    
    [self.navigationView addSubview:titleView];
}

- (void)createNavigationBarLeftItemWithTitle:(__kindof NSString *)title {
    
    [self.leftButton setTitle:title forState:UIControlStateNormal];
    [self.leftButton setTitle:title forState:UIControlStateSelected | UIControlStateHighlighted];
    
    
    CGFloat labelWidth = [self.leftButton.titleLabel.text zyc_widthForFont:self.leftButton.titleLabel.font];
    CGFloat labelHeight = [self.leftButton.titleLabel.text zyc_heightForFont:self.leftButton.titleLabel.font width:labelWidth];
    CGFloat height =  [self heightForNavigationView];
    
    self.leftButton.frame = CGRectMake(8, (height - labelHeight) / 2, kBackButtonWidth, labelHeight);
    [self.navigationView addSubview:self.leftButton];
    
}

- (void)createNavigationBarLeftItemWithImageName:(NSString *)imageName {
    
    [self.leftButton setImage:[[UIImage imageNamed:imageName ?: @"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.leftButton setImage:[[UIImage imageNamed:imageName ?: @"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted | UIControlStateSelected];
    self.leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    self.leftButton.frame = CGRectMake(15, 7, 44, 30);
    [self.leftButton setEnlargeEdgeWithTop:5 right:15 bottom:5 left:10];
    [self.navigationView addSubview:self.leftButton];
    
}

- (void)createNavigationBarRightItemWithTitle:(__kindof NSString *)title {
    
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    [self.rightButton setTitle:title forState:UIControlStateSelected | UIControlStateHighlighted];
    
    CGFloat labelWidth = [self.rightButton.titleLabel.text zyc_widthForFont:self.rightButton.titleLabel.font];
    CGFloat labelHeight = [self.rightButton.titleLabel.text zyc_heightForFont:self.rightButton.titleLabel.font width:labelWidth];
    CGFloat height =  [self heightForNavigationView];
    
    self.rightButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - labelWidth - 8, (height - labelHeight) / 2, labelWidth, labelHeight);
    [self.navigationView addSubview:self.rightButton];
    
}

- (void)createNavigationBarRightItemWithImageName:(NSString *)imageName {
    
    [self.rightButton setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.rightButton setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted | UIControlStateSelected];
    
    self.rightButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40 - 8, 7, 44, 30);
    self.rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.navigationView addSubview:self.rightButton];
    
}

- (void)createNavigationBarRightItemWithCustomView:(UIView *)rightView {
    CGFloat height =  [self heightForNavigationView];
    rightView.center = CGPointMake([UIScreen mainScreen].bounds.size.width - CGRectGetWidth(rightView.bounds) * 0.5 - 8 , height * 0.5);
    [self.navigationView addSubview:rightView];
}

- (void)clickNavBarLeftButton:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.isPresented) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)clickNavBarRightButton:(UIButton *)sender {
    
}

- (void)setupNavView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.statusBarView.backgroundColor = [UIColor clearColor];
    self.navigationView.backgroundColor = [UIColor clearColor];
}

- (void)setupEmptyDataSet {
    
}

- (void)zyc_setBackgroundAlpha:(CGFloat)alpha {
    self.statusBarView.alpha = alpha;
    self.navigationView.alpha = alpha;
    self.statusBarImageView.alpha = alpha;
    self.navigationImageView.alpha = alpha;
    self.bottomLine.alpha = alpha;
}

#pragma mark - setter

- (void)setShowNav:(BOOL)showNav {
    _showNav = showNav;
    if (showNav == NO) {
        [self.navigationView removeFromSuperview];
        [self.statusBarView removeFromSuperview];
        [self.shadowImageV removeFromSuperview];
        [self.navigationImageView removeFromSuperview];
    }
}

- (void)setShowBottomLine:(BOOL)showBottomLine {
    _showBottomLine = showBottomLine;
    
    if (showBottomLine) {
        [self.navigationView addSubview:self.bottomLine];
    } else {
        [self.bottomLine removeFromSuperview];
    }
    
}

- (void)setShowShadowImage:(BOOL)showShadowImage {
    
    _showShadowImage = showShadowImage;
    if (showShadowImage) {
        [self.view addSubview:self.shadowImageV];
    } else {
        [self.shadowImageV removeFromSuperview];
    }
}

- (void)setShowNavBarImage:(BOOL)showNavBarImage {
    
    _showNavBarImage = showNavBarImage;
    if (showNavBarImage) {
        self.statusBarImageView.image = self.navigationImageView.image = [UIImage imageNamed:kNavBarImageName];
    } else {
        self.statusBarImageView.image = self.navigationImageView.image = nil;
    }
}

- (void)setStatusBarBackgroundColor:(UIColor *)statusBarBackgroundColor {
    _statusBarBackgroundColor = statusBarBackgroundColor;
    self.statusBarView.backgroundColor = statusBarBackgroundColor;
}

- (void)setNavBarTitleColor:(UIColor *)navBarTitleColor {
    _navBarTitleColor = navBarTitleColor;
    self.titleLabel.textColor = navBarTitleColor;
}

- (void)setDetailText:(NSString *)detailText {
    _detailText = [detailText copy];
    _detailLabel.text = detailText;
    
    if (self.detailText && ![self.detailText isEqualToString:@""]) {
        
        CGFloat detailLabelW = [self.detailLabel.text zyc_widthForFont:self.detailLabel.font];
        CGFloat detailLabelH = [self.detailLabel.text zyc_heightForFont:self.detailLabel.font width:detailLabelW];
        CGFloat height =  [self heightForNavigationView];
        
        self.detailLabel.frame = CGRectMake(44 + 8, (height - detailLabelH) - 8, [UIScreen mainScreen].bounds.size.width - (44 + 8) * 2, detailLabelH);
        
        CGRect titleFrame = self.titleLabel.frame;
        titleFrame.origin.y = height - detailLabelH - 8 - titleFrame.size.height - 3;
        self.titleLabel.frame = titleFrame;
        
        [self.navigationView addSubview:self.detailLabel];
    }
}

#pragma mark - getter

- (UIView *)statusBarView {
    if (!_statusBarView) {
        _statusBarView = [[UIView alloc]init];
    }
    return _statusBarView;
}

- (UIImageView *)statusBarImageView {
    
    if (!_statusBarImageView) {
        _statusBarImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kNavBarImageName]];
    }
    return _statusBarImageView;
}

- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[UIView alloc]init];
    }
    return _navigationView;
}

- (UIImageView *)navigationImageView {
    if (!_navigationImageView) {
        _navigationImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kNavBarImageName]];
    }
    return _navigationImageView;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
    }
    return _bottomLine;
}

- (UIImageView *)shadowImageV {
    if (!_shadowImageV) {
        _shadowImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_shadow"]];
    }
    return _shadowImageV;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton addTarget:self action:@selector(clickNavBarLeftButton:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_rightButton addTarget:self action:@selector(clickNavBarRightButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

@end
