//
//  SNWebViewController.m
//  StudyNewspaperStudent
//
//  Created by zhongda on 2018/6/7.
//  Copyright © 2018年 zhongdayingcai. All rights reserved.
//

#import "SGWebViewController.h"
#import <WebKit/WebKit.h>

@interface SGWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation SGWebViewController

- (instancetype)init {
    return [self initWithUrl:@"" title:@""];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithUrl:@"" title:@""];
}

- (instancetype)initWithUrl:(NSString *)url
                      title:(NSString *)itemTitle {
    self = [super init];
    if (self) {
        _linkUrl = url;
        _itemTitle = itemTitle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    if (self.linkUrl && ![self.linkUrl isEqualToString:@""]) {
        [self loadRequest];
    }
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = CGRectMake(0, self.navBarHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.navBarHeight);
    self.progressView.frame = CGRectMake(0, self.navBarHeight, CGRectGetWidth(self.view.bounds), 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([object isEqual:self.webView] && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newProgress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:newProgress animated:NO];
        } else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newProgress animated:YES];
        }
    }
    
}

#pragma mark - inherit method

- (void)setupNavView {
    [super setupNavView];
    [self createNavigationBarWithTitle:self.itemTitle];
    [self createNavigationBarLeftItemWithImageName:nil];
    
}

#pragma mark - private method

- (void)loadRequest {
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.linkUrl]];
    [self.webView loadRequest:urlRequest];
    
}

#pragma mark - setter

- (void)setLinkUrl:(NSString *)linkUrl {
    
    _linkUrl = [linkUrl copy];
    if (linkUrl && ![linkUrl isEqualToString:@""]) {
        [self loadRequest];
    }
}

#pragma mark - getter

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc]init];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        
        _webView.allowsBackForwardNavigationGestures = YES;
        
        //以下是让网页自适应手机屏幕（在网页没有适配手机屏幕的时候）
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        _webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:wkWebConfig];
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]init];
        _progressView.tintColor = NavigationColor;
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

@end
