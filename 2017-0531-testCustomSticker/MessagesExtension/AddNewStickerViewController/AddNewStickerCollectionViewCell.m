//
//  AddNewStickerCollectionViewCell.m
//  2017-0531-testCustomSticker
//
//  Created by 007 on 2017/5/31.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "AddNewStickerCollectionViewCell.h"

@interface AddNewStickerCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView ;

@end

@implementation AddNewStickerCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.imageView];
        
    }
    return self;
}

#pragma mark - setter

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName.copy;
    
    self.imageView.image = [UIImage imageNamed:_imageName];
    
    self.imageView.frame = self.contentView.bounds;
}

#pragma mark - getter

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

@end

NSString *kAddNewStickerCollectionViewCellIdentifier = @"kAddNewStickerCollectionViewCellIdentifier";

