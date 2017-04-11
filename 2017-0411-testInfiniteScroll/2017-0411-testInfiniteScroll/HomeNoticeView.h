//
//  HomeNoticeView.h
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/31.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kHomeHeaderNoticeViewHeight = 35.0 ;

static const CGFloat kHomeHeaderNoticeImageViewLeftMargin = 15.0;
static const CGFloat kHomeHeaderNoticeLabelLeftMargin = 10.0;

static const CGFloat kHomeHeaderNoticeLabelRightMargin = 35.0;

@class HomeNoticeView;

@protocol HomeNoticeViewDelegate <NSObject>

@optional

- (void)homeNoticeViewDidSelectNotice:(HomeNoticeView *) homeNoticeView ;

@end

@interface HomeNoticeView : UIView

@property (nonatomic, strong) NSArray *dataSourceArray ;

@property (nonatomic, weak) id<HomeNoticeViewDelegate> delegate ;

- (void)startScrollToUp;

@end
