//
//  HomeNoticeView.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/31.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "HomeNoticeView.h"


#pragma mark - *****************************HomeNoticeViewCollectionViewCell***************************************

@interface HomeNoticeViewCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label ;

@end

@implementation HomeNoticeViewCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.label];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.equalTo(self.contentView);
        }];
        
    }
    return self;
}

#pragma mark - getter
-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        
        _label.font = [UIFont systemFontOfSize:12.0];
        _label.textColor = COLOR_HEX(0x333333, 1.0);
    
    }
    return _label;
}

@end

NSString *const kHomeNoticeViewCollectionViewCellIdentifier = @"kHomeNoticeViewCollectionViewCellIdentifier";

#pragma mark - *****************************HomeNoticeView***************************************


@interface HomeNoticeView ()

    <
        UICollectionViewDelegate,
        UICollectionViewDataSource
    >

@property (nonatomic, strong) UICollectionView *noticeCollectionView ;
@property (nonatomic, strong) NSTimer *noticeUpTimer ;

@property (nonatomic, assign) int currentPage ;

@end

@implementation HomeNoticeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.noticeCollectionView];
        
        self.currentPage = 1;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeNoticeViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeNoticeViewCollectionViewCellIdentifier forIndexPath:indexPath];
    
    cell.label.text = [NSString stringWithFormat:@"我是标题---%d",arc4random_uniform(255)];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(homeNoticeViewDidSelectNotice:)]) {
        [self.delegate homeNoticeViewDidSelectNotice:self];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.y + kHomeHeaderNoticeViewHeight * 0.5) / kHomeHeaderNoticeViewHeight  ;
    self.currentPage = page + 1;
}

#pragma mark - event method
// 轮播器
- (void)timerAction{
    
    if (self.dataSourceArray.count > 0) {
        
        if (self.currentPage == self.dataSourceArray.count) {
            self.currentPage = 2;
        }
        
        [self calculateScrollPosition];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentPage inSection:0];
        
        [self.noticeCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }
}

#pragma mark - public method

- (void)startScrollToUp{
    [self addTimer];
}

#pragma mark - private method

- (void)addTimer{
    
    if (self.dataSourceArray.count <= 1) {
        return;
    }
    
    if (self.noticeUpTimer) {
        return;
    }
    
    self.noticeUpTimer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.noticeUpTimer forMode:NSDefaultRunLoopMode];
}

- (void)cancleTime{
    [self.noticeUpTimer invalidate];
    self.noticeUpTimer = nil;
}

- (void)calculateScrollPosition{
    
    int selectPage = self.noticeCollectionView.contentOffset.y / kHomeHeaderNoticeViewHeight ;
    
    if (selectPage == 0) {
        
        [self.noticeCollectionView setContentOffset:CGPointMake(0, kHomeHeaderNoticeViewHeight  * (self.dataSourceArray.count - 2)) animated:NO];
    }
    // 如果是最后一张
    else if(selectPage == self.dataSourceArray.count - 1) {
        [self.noticeCollectionView setContentOffset:CGPointMake(0, kHomeHeaderNoticeViewHeight ) animated:NO];
    }
}

#pragma mark - setter

-(void)setDataSourceArray:(NSArray *)dataSourceArray{
    
    if (dataSourceArray.count == 1) {
        
        _dataSourceArray = dataSourceArray.copy;
    }else if(dataSourceArray.count == 2) {
        NSMutableArray *tempArray = [NSMutableArray array];
        
        [tempArray addObject:dataSourceArray.lastObject];
        [tempArray addObjectsFromArray:dataSourceArray.copy];
        [tempArray addObject:dataSourceArray.firstObject];
        
        _dataSourceArray = tempArray.copy;
    }else{
        NSMutableArray *tempArray = [NSMutableArray array];
        
        [tempArray addObject:dataSourceArray.firstObject];
        [tempArray addObjectsFromArray:dataSourceArray.copy];
        [tempArray addObject:dataSourceArray.lastObject];
        
        _dataSourceArray = tempArray.copy;
    }
    
    [self.noticeCollectionView reloadData];
    
    if (_dataSourceArray.count > 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        
        [self.noticeCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    [self addTimer];
}

#pragma mark - getter

-(UICollectionView *)noticeCollectionView{
    if (!_noticeCollectionView) {
        
        CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width - (kHomeHeaderNoticeImageViewLeftMargin + kHomeHeaderNoticeViewHeight + kHomeHeaderNoticeLabelLeftMargin + kHomeHeaderNoticeLabelLeftMargin );
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(itemWidth, kHomeHeaderNoticeViewHeight);
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        
        _noticeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, itemWidth, kHomeHeaderNoticeViewHeight ) collectionViewLayout:layout];
        
        _noticeCollectionView.delegate = self;
        _noticeCollectionView.dataSource = self;
        
        _noticeCollectionView.showsHorizontalScrollIndicator = NO;
        _noticeCollectionView.scrollEnabled = NO;
        _noticeCollectionView.backgroundColor = [UIColor whiteColor];
        _noticeCollectionView.pagingEnabled = YES;
        
        [_noticeCollectionView registerClass:[HomeNoticeViewCollectionViewCell class] forCellWithReuseIdentifier:kHomeNoticeViewCollectionViewCellIdentifier];
        
    }
    return _noticeCollectionView;
}

@end
