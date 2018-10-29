//
//  ViewController.m
//  2018-0830-testWKWebview
//
//  Created by wkj on 2018/8/30.
//  Copyright © 2018年 wkj. All rights reserved.
//

#import "ViewController.h"
#import "FLCBaseWebViewController.h"
#import "WebViewController.h"

#import <QuickLook/QuickLook.h>

#import "AFNetworking.h"
#import "PDFWebView.h"


@interface ViewController ()

    <
        QLPreviewControllerDataSource,
        QLPreviewControllerDelegate
    >

@property (strong, nonatomic)QLPreviewController *previewController;

@property (copy, nonatomic)NSURL *fileURL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//
//    PDFWebView *webView = [[PDFWebView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:webView];
//    NSString *pdfFilePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"pdf"];
//    [webView loadPDFFile:pdfFilePath];
//
//    return;
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    NSString *urlStr = @"http://puhui-lend-finupcredit-lend.oss.test//upload/puhui-lend/contracts/2018-09-17/783480/credit_protocol_iqianjin_new.pdf?e=1537264275&token=C3IleWopQJhe5dsbJSU6jAWfqk3LFzcdwnQMQXTL:D4qxf1Xhi_KgXOnbcTWMCk9jwu0=";
//    NSString *fileName = @"credit_protocol_iqianjin_new.pdf";
//    NSURL *URL = [NSURL URLWithString:urlStr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress){
//
//    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
//        return url;
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//
//        self.fileURL = filePath;
//
//        self.previewController = [[QLPreviewController alloc] init];
//
//        self.previewController.dataSource = self;
//
//        self.previewController.delegate = self;
//
//        [self presentViewController:self.previewController animated:YES completion:nil];
//        [self.previewController refreshCurrentPreviewItem];
//    }];
//    [downloadTask resume];
    
    
    FLCBaseWebViewController *webViewController = [[FLCBaseWebViewController alloc] initWithUrl:@"http://puhui-lend-finupcredit-lend.oss.test//upload/puhui-lend/contracts/2018-09-17/783480/credit_protocol_iqianjin_new.pdf?e=1537264275&token=C3IleWopQJhe5dsbJSU6jAWfqk3LFzcdwnQMQXTL:D4qxf1Xhi_KgXOnbcTWMCk9jwu0=" withTitle:@""];
    
//    WebViewController *webViewController = [WebViewController new];
    
    UINavigationController *webNav = [[UINavigationController alloc] initWithRootViewController:webViewController];
    
    [self presentViewController:webNav animated:YES completion:nil];
     
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    
    return 1;
}

- (id)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    
    return self.fileURL;
}



@end
