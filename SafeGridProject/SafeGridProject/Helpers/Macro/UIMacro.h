//
//  UIMacro.h
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/8.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#ifndef UIMacro_h
#define UIMacro_h

#define SCREEN_HEIGHT                           ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH                            ([UIScreen mainScreen].bounds.size.width)

#define WIDTHSCALE6                             (float)(SCREEN_WIDTH/375.0f)
#define HEIGHTSCALE6                            (float)(SCREEN_HEIGHT/667.0f)
#define IS_IPhoneX                              (((int)((SCREEN_HEIGHT/SCREEN_WIDTH)*100) == 216)?YES:NO)
#define TabBar_Height                           (IS_IPhoneX ? 83 : 49)//UITabBar高度 iPhone X = 83，其他49
#define Bottom_SafeHeight                       (IS_IPhoneX ? 34 : 0)//底部安全高度 iPhone X = 34，其他0
#define NavBar_Height                           (IS_IPhoneX ? 88 : 64)//导航栏高度 iPhone X = 88，其他64
#define NavStatusBar_Height                     (IS_IPhoneX ? 44 : 20) //状态栏高度 iPhone X = 44，其他20

#define UIRatio                                 1
#define Color_RGB(r, g, b, a)                   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]

#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

#define WEAKSELF    __weak __typeof(&*self) ws = self;

//本地存储
#define DEFAULT [NSUserDefaults standardUserDefaults]

#define ThemeColor      COLOR_WITH_HEX(0xE5473C)

#define NavigationColor COLOR_WITH_HEX(0xe9493d)

#define BGGrayColor Color_RGB(245, 245, 245, 1)    


#define SGPlayHeight SCREEN_WIDTH * 9 / 16.f + NoStatusBarSafeTop


//导航栏背景图片名称
#define NAVIGATIONBAR_IMAGENAME                  @"nav_background_image"
//单独阴影
#define SHADOW_IMAGENAME                         @"icon_shadow"
//占位图
#define SG_PLACEHOLDER_IMAGE                    [UIImage imageNamed:@"teacherTeam_icon"]
#define SG_PLACEHOLDER_IMAGE_2                  [UIImage imageNamed:@"head_icon"]
#define SG_COURSE_PLACEHOLDER_IMAGE             [UIImage imageNamed:@"course_icon"]
#define SG_VIDEO_PLACEHOLDER_IMAGE              [UIImage imageNamed:@"video_icon"]

#define DOWNLOAD_FILE_COUNT                       @"DOWNLOAD_FILE_COUNT"
#define HOMELIST_DATA_DOWNLOAD                    @"HOMELIST_DATA_DOWNLOAD"


//播放器导航栏渐变
#define NAVBAR_COLORCHANGE_POINT (HEADER_HEIGHT - NavBar_Height)
//播放器高度
#define HEADER_HEIGHT (SCREEN_WIDTH * 9 / 16.f + NoStatusBarSafeTop)
#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})

typedef NS_ENUM(NSInteger, SGPlayerVideoType) {
    SGPlayerVideoTypeNone,
    SGPlayerVideoTypeCourseDetail,
    SGPlayerVideoTypeLiving,
    SGPlayerVideoTypeTypeRecord,
};

typedef NS_ENUM(NSInteger, QuestionType) {
    
    QuestionTypeSingleChoice = 1,//单选
    QuestionTypeMultiChoice = 2,//多选
    QuestionTypeJudge = 3,//判断题
    QuestionTypeMaterial = 100,//材料题
    QuestionTypeMaterialSingleChoice = 5,//材料题-单选
    QuestionTypeMaterialMultiChoice = 6,//材料题-多选
    QuestionTypeMaterialJudge = 7//材料题-判断
    
};

//练习题内边距
#define kExerciseStemTopEdges   30
#define kExerciseStemBottomEdges 10
#define kExerciseStemLeftEdges   20

#endif /* UIMacro_h */
