//
//  WebViewController.m
//  2018-0830-testWKWebview
//
//  Created by wkj on 2018/8/30.
//  Copyright © 2018年 wkj. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://newbrand.finup-credit.com/spa/app/novice-spree/step-one?downChannel=%E4%B8%AA%E8%B4%B7"]]];
}


@end
