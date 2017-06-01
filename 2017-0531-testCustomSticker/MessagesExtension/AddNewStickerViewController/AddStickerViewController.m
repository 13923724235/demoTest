//
//  AddStickerViewController.m
//  2017-0531-testCustomSticker
//
//  Created by 007 on 2017/5/31.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "AddStickerViewController.h"

#import <Messages/Messages.h>
#import "AddNewStickerCollectionViewCell.h"


@interface AddStickerViewController ()

    <
        UICollectionViewDataSource,
        UICollectionViewDelegate
    >

@property (nonatomic, strong) UICollectionView *collectionView ;

@property (nonatomic, strong) NSMutableArray *stickersArrayM ;

@end

@implementation AddStickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
    
    AddNewStickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAddNewStickerCollectionViewCellIdentifier forIndexPath:indexPath];
    
    cell.imageName = self.stickersArrayM[indexPath.item];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.delegate respondsToSelector:@selector(addStickerViewControllerDidSelectSticker:)]) {
        
        NSString *imageName = self.stickersArrayM[indexPath.item];
        
        NSString *stickerPath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
        
        NSURL *stickerUrl = [NSURL fileURLWithPath:stickerPath];
        
        MSSticker *sticker = [[MSSticker alloc] initWithContentsOfFileURL:stickerUrl localizedDescription:imageName error:NULL];
        
        [self.delegate addStickerViewControllerDidSelectSticker:sticker];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0){
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
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
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10.0, 86.0, [UIScreen mainScreen].bounds.size.width - 20.0, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[AddNewStickerCollectionViewCell class] forCellWithReuseIdentifier:kAddNewStickerCollectionViewCellIdentifier];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}

-(NSMutableArray *)stickersArrayM{
    if (!_stickersArrayM) {
        _stickersArrayM = [NSMutableArray array];
        
        for (int i = 14; i < 20; i ++) {
            
            NSString *imageName = [NSString stringWithFormat:@"test%d.jpg",i];
            
            [_stickersArrayM addObject:imageName];
        }
        
    }
    return _stickersArrayM;
}

@end
