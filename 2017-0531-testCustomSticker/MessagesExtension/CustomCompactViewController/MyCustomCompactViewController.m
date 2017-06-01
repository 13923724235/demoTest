//
//  MyCustomCompactViewController.m
//  2017-0531-testCustomSticker
//
//  Created by 007 on 2017/5/31.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "MyCustomCompactViewController.h"


#import "MyCollectionViewCell.h"
#import "AddStickerCell.h"

#import <Messages/Messages.h>

@interface MyCustomCompactViewController ()

    <
        UICollectionViewDataSource,
        UICollectionViewDelegate
    >

@property (nonatomic, strong) UICollectionView *collectionView ;

@property (nonatomic, strong) NSMutableArray *stickersArrayM ;

@end

@implementation MyCustomCompactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.stickersArrayM.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        
        AddStickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAddStickerCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else{
        
        MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyCollectionViewCellIdentifier forIndexPath:indexPath];
        
        cell.sticker = self.stickersArrayM[indexPath.item];
        
        return cell;
    }
    
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 0) {
        
        if ([self.delegate respondsToSelector:@selector(myCustomCompactViewControllerDidSelectAddOtherStickerItem)]) {
            [self.delegate myCustomCompactViewControllerDidSelectAddOtherStickerItem];
        }
    }
    else{
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0){
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - public method

- (void)addNewSticker:(MSSticker *) sticker{
    [self.stickersArrayM insertObject:sticker atIndex:1];
    
    [self.collectionView reloadData];
}

#pragma mark - getter

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 20.0 )  / 4;
        
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        layout.minimumInteritemSpacing = 0.0;
        layout.minimumLineSpacing = 0.0;
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10.0, 10.0, [UIScreen mainScreen].bounds.size.width - 20.0, itemWidth * 2 - 20.0) collectionViewLayout:layout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:kMyCollectionViewCellIdentifier];
        [_collectionView registerClass:[AddStickerCell class] forCellWithReuseIdentifier:kAddStickerCellIdentifier];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}

-(NSMutableArray *)stickersArrayM{
    if (!_stickersArrayM) {
        _stickersArrayM = [NSMutableArray array];
        
        for (int i = 1; i < 10; i ++) {
            
            if (i == 1) {
                
                [_stickersArrayM addObject:@"😄"];
                
                continue;
            }
            
            NSString *imageName = [NSString stringWithFormat:@"test%d",i];
            
            NSString *stickerPath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
            
            NSURL *stickerUrl = [NSURL fileURLWithPath:stickerPath];
            
            MSSticker *sticker = [[MSSticker alloc] initWithContentsOfFileURL:stickerUrl localizedDescription:imageName error:NULL];
            
            [_stickersArrayM addObject:sticker];
        }
        
    }
    return _stickersArrayM;
}

@end
