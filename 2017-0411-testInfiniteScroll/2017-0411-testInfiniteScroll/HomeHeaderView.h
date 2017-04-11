//
//  HomeHeaderView.h
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/13.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kHomeHeaderViewHegith = 150.0;

@class HomeHeaderView,HomeNotice;

@protocol HomeHeaderViewDelegate <NSObject>


@optional

/*
 *  点击头部banber的代理事件
 *
 *  @param headerView 当前的头部 视图
 *
 */
- (void)headerViewDidClickBannerImageView:(HomeHeaderView *) headerView bannerUrlString:(NSString *) bannerUrlString;

/*
 *  点击头部公告的代理事件
 *
 *  @param headerView 当前的头部 视图
 *
 */
- (void)headerView:(HomeHeaderView *) headerView didSelctHomenotice:(HomeNotice *) homeNotice;

/*
 *  点击头部更多公告按钮的代理事件
 *
 *  @param headerView 当前的头部 视图
 *
 */
- (void)headerViewDidSelectMoreNoticeButton:(HomeHeaderView *) headerView ;

@end

@interface HomeHeaderView : UIView

@property (nonatomic, weak) id<HomeHeaderViewDelegate> delegate ;

@property (nonatomic, strong) NSArray *bannerImageViewArray ;

@property (nonatomic, strong) NSArray *noticeArray ;

+ (instancetype)headerView;

- (void)startScroll;

@end
