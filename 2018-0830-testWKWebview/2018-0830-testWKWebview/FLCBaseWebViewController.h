//
//  FLCBaseWebViewController.h
//  FinupLoanCustomer
//
//  Created by wkj on 2018/6/11.
//  Copyright © 2018年 普惠金融. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FLCBaseWebViewController : UIViewController

- (instancetype)initWithUrl:(NSString *)url withTitle:(NSString *)title;

@property (nonatomic, assign) BOOL loadSuccessHiddenBar ;

@end

UIKIT_EXTERN NSString *const kFLCBaseWebViewControllerCloseWebViewScript;
UIKIT_EXTERN NSString *const kFLCBaseWebViewControllerTestAnswerScript;

UIKIT_EXTERN NSString *const kFLCBaseWebViewControllerSelectProductScript;

UIKIT_EXTERN NSString *const kFLCBaseWebViewControllerSelectDistrictScript;


