//
//  ZYCBaseViewController.h
//  JHNews
//
//  Created by 周永超 on 2017/4/20.
//  Copyright © 2017年 xiaozhang. All rights reserved.
//

#import "ZYCEmptyDataSetController.h"
#import "UIView+Indicator.h"
#import "WeakAndStrongDefine.h"

@interface ZYCBaseViewController : ZYCEmptyDataSetController

/*
 =================================================说明============================================
 
 如果需要自定义导航栏，子类可以继承此类，根据需求来制定导航栏样式。继承此类后，子类尽可能统一调用setupNavView方法
 来初始化导航栏，这样有利于代码的可读性。
 
 注意：目前此类中实现了定制导航栏的基本需求，子类根据项目需求调用相应方法。但是其中有的方法不能并存，只能选择其一进
 行调用。
 例如：- (void)createNavigationBarWithTitle:(__kindof NSString *)title
 backgroundImageName:(NSString *)imageName;与- (void)createNavigationBarWithTitleView:(UIView *)titleView;
 不能同时调用，只能二者选其一。调用什么方法根据项目需求即可。如此类中无法实现项目需求，则可在子类中自行定制。
 
 子类中如果想获得点击左侧和右侧按钮触发的事件，只需实现- (void)clickNavBarLeftButton:(UIButton *)sender;和
 - (void)clickNavBarRightButton:(UIButton *)sender;即可。
 
 =================================================结束============================================
 */

/**
 设置是否显示导航视图，默认为YES，在viewDidLoad之后设置 如果不需要显示导航视图设置为NO
 */
@property (nonatomic, assign) BOOL showNav;

/**
 设置是否显示导航栏下部线条
 */
@property (nonatomic, assign) BOOL showBottomLine;

/**
 是否显示导航栏下面阴影图片
 */
@property (nonatomic, assign) BOOL showShadowImage;

/**
 是否显示导航栏背景图片
 */
@property (nonatomic, assign) BOOL showNavBarImage;

/**
 导航栏下面阴影图片
 */
@property (nonatomic, strong) UIImageView *shadowImageV;

/**
 标识本视图是否是被Presented
 */
@property (nonatomic, assign) BOOL isPresented;

/**
 设置状态栏背景颜色
 */
@property (nonatomic, strong) UIColor *statusBarBackgroundColor;

/**
 设置标题颜色 默认0x5d5d5d
 */
@property (nonatomic, strong) UIColor *navBarTitleColor;

/**
 detailLabel的显示文字
 */
@property (nonatomic, copy) NSString *detailText;

@property (nonatomic, strong, readonly) UIView *statusBarView;
@property (nonatomic, strong, readonly) UIView *navigationView;
@property (nonatomic, strong, readonly) UILabel       *titleLabel;
@property (nonatomic, strong, readonly) UIView        *bottomLine;

@property (nonatomic, strong, readonly) UIButton      *leftButton;
@property (nonatomic, strong, readonly) UIButton      *rightButton;

@property (nonatomic, assign, readonly) CGFloat statusBarHeight;

@property (nonatomic, assign, readonly) CGFloat navBarHeight;

@property (nonatomic, assign, readonly) CGFloat tabBarHeight;

/**
 设置导航栏的标题

 @param title 标题内容
 */
- (void)createNavigationBarWithTitle:(__kindof NSString *)title;

/**
 设置导航栏的标题和背景图片

 @param title 标题
 @param imageName 背景图片
 */
- (void)createNavigationBarWithTitle:(__kindof NSString *)title
                 backgroundImageName:(NSString *)imageName;

/**
 设置导航栏的详情副标题

 @param title 标题
 */
- (void)createNavigationBarWithDetailTitle:(__kindof NSString *)title;

/**
 设置导航栏中间视图

 @param titleView 中间视图
 */
- (void)createNavigationBarWithTitleView:(UIView *)titleView;

/**
 设置导航栏中间视图及背景图片

 @param titleView 中间视图
 @param imageName 背景图片
 */
- (void)createNavigationBarWithTitleView:(UIView *)titleView
                backgroundImageName:(NSString *)imageName;

/**
 设置一个带有文字内容的右侧导航栏按钮

 @param title 文字内容
 */
- (void)createNavigationBarLeftItemWithTitle:(__kindof NSString *)title;

/**
 设置一个带有图片的左侧导航栏按钮

 @param imageName 图片名称
 */
- (void)createNavigationBarLeftItemWithImageName:(NSString *)imageName;

/**
 设置一个带有文字内容的右侧导航栏按钮

 @param title 文字内容
 */
- (void)createNavigationBarRightItemWithTitle:(__kindof NSString *)title;

/**
 设置一个带有图片的右侧导航栏按钮

 @param imageName 图片名称
 */
- (void)createNavigationBarRightItemWithImageName:(NSString *)imageName;

/**
 设置一个带有自定义View的导航栏右侧按钮

 @param rightView 自定义rightView
 */
- (void)createNavigationBarRightItemWithCustomView:(UIView *)rightView;


/**
 点击导航栏左侧按钮触发的事件

 @param sender 左侧控件
 */
- (void)clickNavBarLeftButton:(UIButton *)sender;

/**
 点击导航栏右侧按钮触发的事件

 @param sender 右侧控件
 */
- (void)clickNavBarRightButton:(UIButton *)sender;

/**
 设置背景颜色透明度

 @param alpha 透明度
 */
- (void)zyc_setBackgroundAlpha:(CGFloat)alpha;

/**
 子类统一实现此方法来初始化导航栏，子类也可以在自己的文件中写方法来初始化导航栏
 */
- (void)setupNavView NS_REQUIRES_SUPER;

/**
 在此方法中初始化空视图的显示格式
 */
- (void)setupEmptyDataSet;

@end
