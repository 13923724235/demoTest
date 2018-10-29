//
//  FLCBaseWebViewController.m
//  FinupLoanCustomer
//
//  Created by wkj on 2018/6/11.
//  Copyright © 2018年 普惠金融. All rights reserved.
//

#import "FLCBaseWebViewController.h"

#import <WebKit/WebKit.h>

@interface FLCBaseWebViewController ()

    <
        WKNavigationDelegate,
        WKUIDelegate,
        WKScriptMessageHandler
    >


@property (nonatomic, strong) WKWebView *webView ;

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) BOOL isHiddenBar ;

@end

@implementation FLCBaseWebViewController

#pragma mark - life cycle

- (instancetype)initWithUrl:(NSString *)url withTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.url = url;
        self.navigationItem.title = title ?: @"网页详情";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutSubviews];
    
    [self loadRequest];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.progressView removeFromSuperview];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

- (void)dealloc {
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    decisionHandler(WKNavigationActionPolicyAllow + 2);      // 拦截Universal links的行为
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    
    self.progressView.hidden = NO;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    if (self.loadSuccessHiddenBar) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        self.isHiddenBar = YES;
    }
}

// 启动时加载数据失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败%@",error);

    [self loadProgress];
}

// 当一个正在提交的页面在跳转过程中出现错误
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"加载失败%@",error);
    [self loadProgress];
}

#pragma mark - WKUIDelegate     WKWebView将js的alert confirm 和 prompt函数的弹出事件做了拦截，需要手动控制js的弹出与否

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    completionHandler();
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
    completionHandler(YES);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    completionHandler(defaultText);
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSString *hanlderName = message.name;
    
    if ([hanlderName isEqualToString:kFLCBaseWebViewControllerCloseWebViewScript]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - private method

- (void)loadRequest{
    
    // 防止url由于转码问题转换成nil
    NSURL *url = [NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0];
    
    [self.webView loadRequest:request];
}

- (void)loadProgress{
    [self.progressView setProgress:1.0 animated:YES];
}

- (void)layoutSubviews{
    [self.view addSubview:self.webView];
    [self.navigationController.navigationBar addSubview:self.progressView];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == self.webView) {
        
        [self.progressView setAlpha:1.0f];
        
        BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
        
        [self.progressView setProgress:self.webView.estimatedProgress
                              animated:animated];
        
        if (self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.35f
                                  delay:0.35f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 [self.progressView setAlpha:0.0f];
                             }
                             completion:^(BOOL finished) {
                                 [self.progressView setProgress:0.0f animated:NO];
                             }];
        }
    }
}

#pragma mark - setter

#pragma mark - getter

- (WKWebView *)webView{
    if (!_webView) {
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = preferences;
        
        [configuration.userContentController addScriptMessageHandler:self name:kFLCBaseWebViewControllerCloseWebViewScript];
        [configuration.userContentController addScriptMessageHandler:self name:kFLCBaseWebViewControllerTestAnswerScript];
        [configuration.userContentController addScriptMessageHandler:self name:kFLCBaseWebViewControllerSelectProductScript];
        [configuration.userContentController addScriptMessageHandler:self name:kFLCBaseWebViewControllerSelectDistrictScript];

        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        _webView.scrollView.showsVerticalScrollIndicator = YES;
    }
    return _webView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64 - 20, 320, 2)];
        [_progressView setTrackTintColor:[UIColor clearColor]];
        _progressView.progressTintColor = [UIColor colorWithRed:253/255.0 green:130/255.0 blue:36.0/255.0 alpha:1.0];
    }
    return _progressView;
}

@end

NSString *const kFLCBaseWebViewControllerCloseWebViewScript = @"closeWebview";
NSString *const kFLCBaseWebViewControllerTestAnswerScript = @"testAnswer";

NSString *const kFLCBaseWebViewControllerSelectProductScript = @"selectProduct";
NSString *const kFLCBaseWebViewControllerSelectDistrictScript = @"address";

