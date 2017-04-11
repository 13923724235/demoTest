//
//  HomeHeaderView.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/13.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "HomeHeaderView.h"
#import "HomeNoticeView.h"

#pragma mark - HomeBannerCollectionViewCell

@interface HomeBannerCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *bannerImageView ;

@end

@implementation HomeBannerCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.bannerImageView];

        [self.bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.equalTo(self.contentView);
        }];
    }
    return self;
}

#pragma mark - getter

-(UIImageView *)bannerImageView{
    if (!_bannerImageView) {
        _bannerImageView = [[UIImageView alloc] init];
        
        _bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bannerImageView;
}

@end

NSString *const kHomeBannerCollectionViewCellIdentifier = @"kHomeBannerCollectionViewCellIdentifier";

#pragma mark - HomeHeaderView

static const CGFloat kHomeHeaderBannerViewHeight = 115.0 ;
static const CGFloat kHomeHeaderNoticeImageViewWidthHeight = 20.0;


@interface HomeHeaderView ()

    <
        UICollectionViewDelegate,
        UICollectionViewDataSource,
        HomeNoticeViewDelegate
    >

@property (nonatomic, strong) UICollectionView *bannerCollectionView ;
@property (nonatomic, strong) NSTimer *timer ;
@property (nonatomic, assign) int currentPage ;

@property (nonatomic, strong) UIView *noticeView ;
@property (nonatomic, strong) UIImageView *noticeImageView ;
@property (nonatomic, strong) HomeNoticeView *homeNoticeView ;

@property (nonatomic, strong) UIButton *moreButton ;

@end

@implementation HomeHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.currentPage = 1;

    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.bannerCollectionView];
    
    [self addSubview:self.noticeView];
    
    [self addSubview:self.moreButton];
}

+ (instancetype)headerView{
    
    HomeHeaderView *headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHomeHeaderViewHegith )];
    
    [headerView.noticeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headerView);
        make.left.equalTo(headerView);
    }];
    
    [headerView.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView);
        make.centerY.equalTo(headerView.noticeView);
        make.height.equalTo(headerView.noticeView);
        make.width.mas_offset(kHomeHeaderNoticeLabelRightMargin );
    }];
    
    return headerView;
}

#pragma mark - event response

// 轮播器
- (void)timerAction{
    
    if (self.bannerImageViewArray.count > 0) {
        
        if (self.currentPage == self.bannerImageViewArray.count) {
            self.currentPage = 2;
        }
        
        [self calculateScrollPosition];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentPage inSection:0];
        
        [self.bannerCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

- (void)moreButtonClick:(UIButton *) moreButton{
    if ([self.delegate respondsToSelector:@selector(headerViewDidSelectMoreNoticeButton:)]) {
        [self.delegate headerViewDidSelectMoreNoticeButton:self];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.bannerImageViewArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeBannerCollectionViewCellIdentifier forIndexPath:indexPath];
    
//    NSString *imageString = [self.bannerImageViewArray[indexPath.item] objectForKey:@"imgUrl"];
    
    int imageIndex = (int)indexPath.item;
    
    if (indexPath.item == self.bannerImageViewArray.count - 1) {
        imageIndex = 1;
    }
    else if(indexPath.item == 0){
        imageIndex = (int)(self.bannerImageViewArray.count - 2);
    }
    
    cell.bannerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",imageIndex]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickBannerImageView:bannerUrlString:)]) {
        
        NSDictionary *bannerDict = self.bannerImageViewArray[indexPath.item];
        
        NSString *urlString = bannerDict[@"linkUrl"];
        [self.delegate headerViewDidClickBannerImageView:self bannerUrlString:urlString];
    }
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self cancleTime];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = [scrollView contentOffset];
    
    self.currentPage = round(offset.x / [UIScreen mainScreen].bounds.size.width) + 1;
    
    [self calculateScrollPosition];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.x + (scrollView.width) * 0.5)/ scrollView.width ;
    self.currentPage = page + 1;
}

#pragma mark - HomeNoticeViewDelegate

- (void)homeNoticeView:(HomeNoticeView *) homeNoticeView didSelectNotice:(HomeNotice *) homeNotice{
    if ([self.delegate respondsToSelector:@selector(headerView:didSelctHomenotice:)]) {
        [self.delegate headerView:self didSelctHomenotice:homeNotice];
    }
}

#pragma mark - public method

- (void)startScroll{
    [self addTimer];
}

#pragma mark - private method

- (void)addTimer{
    
    if (self.bannerImageViewArray.count <= 1) {
        return;
    }
    
    if (self.timer) {
        return;
    }
    
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)cancleTime{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)calculateScrollPosition{
    
    int selectPage = self.bannerCollectionView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    
    if (selectPage == 0) {
        
        [self.bannerCollectionView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * (self.bannerImageViewArray.count - 2), 0) animated:NO];
    }
    // 如果是最后一张
    else if(selectPage == self.bannerImageViewArray.count - 1) {
        [self.bannerCollectionView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0) animated:NO];
    }
}

#pragma mark - setter

-(void)setBannerImageViewArray:(NSArray *)bannerImageViewArray{
    
    if (bannerImageViewArray.count == 1) {
        
        _bannerImageViewArray = bannerImageViewArray.copy;
        
    }else if(bannerImageViewArray.count == 2){
        NSMutableArray *tempArray = [NSMutableArray array];
        
        [tempArray addObject:bannerImageViewArray.firstObject];
        [tempArray addObjectsFromArray:bannerImageViewArray.copy];
        [tempArray addObject:bannerImageViewArray.lastObject];
        
        _bannerImageViewArray = tempArray.copy;
    }else{
        NSMutableArray *tempArray = [NSMutableArray array];
        
        [tempArray addObject:bannerImageViewArray.firstObject];
        [tempArray addObjectsFromArray:bannerImageViewArray.copy];
        [tempArray addObject:bannerImageViewArray.lastObject];
        
        _bannerImageViewArray = tempArray.copy;
    }
    
    [self.bannerCollectionView reloadData];
    
    if (_bannerImageViewArray.count > 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        
        [self.bannerCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    [self addTimer];

}

-(void)setNoticeArray:(NSArray *)noticeArray{
    _noticeArray = noticeArray.copy;
    
    self.homeNoticeView.dataSourceArray = _noticeArray;
}

#pragma mark - getter 

-(UICollectionView *)bannerCollectionView{
    if (!_bannerCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, kHomeHeaderBannerViewHeight );
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        
        _bannerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHomeHeaderBannerViewHeight ) collectionViewLayout:layout];
        
        _bannerCollectionView.delegate = self;
        _bannerCollectionView.dataSource = self;
        
        _bannerCollectionView.pagingEnabled = YES;
        _bannerCollectionView.showsHorizontalScrollIndicator = NO;
        
        _bannerCollectionView.backgroundColor = [UIColor whiteColor];

        [_bannerCollectionView registerClass:[HomeBannerCollectionViewCell class] forCellWithReuseIdentifier:kHomeBannerCollectionViewCellIdentifier];
        
    }
    return _bannerCollectionView;
}

-(UIView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[UIView alloc] init];
        
        [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo(kHomeHeaderNoticeViewHeight );
        }];
        
        [_noticeView addSubview:self.noticeImageView];
        [_noticeView addSubview:self.homeNoticeView];
        
        [self.noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kHomeHeaderNoticeImageViewWidthHeight );
            make.height.mas_equalTo(kHomeHeaderNoticeImageViewWidthHeight );
            
            make.centerY.equalTo(_noticeView);
            make.left.mas_equalTo(kHomeHeaderNoticeImageViewLeftMargin );
        }];
        
    }
    return _noticeView;
}

-(UIImageView *)noticeImageView{
    if (!_noticeImageView) {
        _noticeImageView = [[UIImageView alloc] init];
        
        _noticeImageView.image = [UIImage imageNamed:@"gonggao"];
    }
    return _noticeImageView;
}

-(HomeNoticeView *)homeNoticeView{
    if (!_homeNoticeView) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width - (kHomeHeaderNoticeImageViewLeftMargin + kHomeHeaderNoticeViewHeight + kHomeHeaderNoticeLabelLeftMargin + kHomeHeaderNoticeLabelRightMargin ) ;
        
        CGFloat leftMargin = (kHomeHeaderNoticeImageViewLeftMargin + kHomeHeaderNoticeImageViewWidthHeight + kHomeHeaderNoticeLabelLeftMargin) ;
        
        _homeNoticeView = [[HomeNoticeView alloc] initWithFrame:CGRectMake(leftMargin, 0, width,  kHomeHeaderNoticeViewHeight )];
        
        _homeNoticeView.delegate = self;
        
    }
    return _homeNoticeView;
}

-(UIButton *)moreButton{
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] init];
        
        [_moreButton setImage:[UIImage imageNamed:@"youjiantou"] forState:UIControlStateNormal];
        
        [_moreButton addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

@end
