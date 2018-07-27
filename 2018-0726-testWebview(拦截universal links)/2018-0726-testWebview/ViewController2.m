//
//  ViewController2.m
//  2018-0726-testWebview
//
//  Created by wkj on 2018/7/26.
//  Copyright © 2018年 wkj. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

    <
        UIWebViewDelegate
    >

@property (nonatomic, strong) UIWebView *webView ;

@end

@implementation ViewController2

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.zhihu.com/question/62897884/answer/445296340?utm_source=ZHShareTargetIDMore&utm_medium=social&utm_oi=1005907124278280192"]]];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *requesUrl = request.URL.absoluteString;
    
    if ([requesUrl containsString:@"oia.zhihu.com"]) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - getter

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
    }
    return _webView;
}

@end
