//
//  ViewController.m
//  2018-0726-testWebview
//
//  Created by wkj on 2018/7/26.
//  Copyright © 2018年 wkj. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

    <
        WKNavigationDelegate,
        WKUIDelegate
    >

@property (nonatomic, strong) WKWebView *webView ;

@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    // https://oia.zhihu.com/apple-app-site-association

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.zhihu.com/question/62897884/answer/445296340?utm_source=ZHShareTargetIDMore&utm_medium=social&utm_oi=1005907124278280192"]]];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSString *requesUrl = navigationAction.request.URL.absoluteString;
    
    if ([requesUrl containsString:@"oia.zhihu.com"]) {
        decisionHandler(WKNavigationActionPolicyAllow + 2);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow );
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

#pragma mark - getter

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds ];

        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        
    }
    return _webView;
}

@end
