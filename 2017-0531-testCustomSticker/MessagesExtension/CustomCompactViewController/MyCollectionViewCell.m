//
//  MyCollectionViewCell.m
//  2017-0531-testCustomSticker
//
//  Created by 007 on 2017/5/31.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import <Messages/Messages.h>

@interface MyCollectionViewCell ()

@property (nonatomic, strong) MSStickerView *stickerView ;

@end

@implementation MyCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.stickerView];
    }
    return self;
}

#pragma mark - setter

-(void)setSticker:(MSSticker *)sticker{
    _sticker = sticker;
    
    self.stickerView.sticker = _sticker;
    
    self.stickerView.frame = self.contentView.bounds;
}

#pragma mark - getter

-(MSStickerView *)stickerView{
    if (!_stickerView) {
        _stickerView = [[MSStickerView alloc] init];
    }
    return _stickerView;
}

@end

NSString * kMyCollectionViewCellIdentifier = @"kMyCollectionViewCellIdentifier";


