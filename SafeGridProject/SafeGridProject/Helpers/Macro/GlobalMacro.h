//
//  GlobalMacro.h
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/8.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#ifndef GlobalMacro_h
#define GlobalMacro_h

#define NetworkErrorCode -2

#define BJOP_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define BJOP_IS_IOS_11  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.f)
#define BJOP_IS_IPHONE_X (BJOP_IS_IOS_11 && BJOP_IS_IPHONE && ((MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 375 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 812) || (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 414 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 896)))

//释放YTKRequest专用
#define HTTPMSG_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF))\
{\
[__REF stop];\
TT_RELEASE_SAFELY(__REF);\
}\
}

#undef TT_RELEASE_SAFELY
#define TT_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF)) \
{\
__REF = nil;\
}\
}

/**
 *  输出size或者Rect
 */
#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)

#ifdef DEBUG
# define DLog(fmt, ...)                         NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
# define DLog(...);
#endif

//判空
#define isEmptyString(s)  (((s) == nil) || ([(s) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0))

//单例
#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    IMP_SINGLETON
#define IMP_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

//防止多次点击
#define kPreventRepeatClickTime(_seconds_)\
static BOOL shouldPrevent;\
if (shouldPrevent) return;\
shouldPrevent = YES;\
dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)((_seconds_) * NSEC_PER_SEC)),dispatch_get_main_queue(),^{\
shouldPrevent = NO;\
});\


#endif /* GlobalMacro_h */
