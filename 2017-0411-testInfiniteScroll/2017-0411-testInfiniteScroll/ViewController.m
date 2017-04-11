//
//  ViewController.m
//  2017-0411-testInfiniteScroll
//
//  Created by 007 on 2017/4/11.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "ViewController.h"

#import "HomeHeaderView.h"

@interface ViewController ()

@property (nonatomic, strong) HomeHeaderView *headerView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.headerView];
    
    self.headerView.bannerImageViewArray = @[@"1",@"2",@"3"];

    self.headerView.noticeArray = @[@"1",@"2",@"3"];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - getter

-(HomeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [HomeHeaderView headerView];
    }
    return _headerView;
}


@end
