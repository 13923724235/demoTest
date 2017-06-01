//
//  AddStickerCell.m
//  2017-0531-testCustomSticker
//
//  Created by 007 on 2017/5/31.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "AddStickerCell.h"

@interface AddStickerCell ()

@property (nonatomic, strong) UIButton *addButton ;

@end

@implementation AddStickerCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.addButton];
        
        self.addButton.center = self.contentView.center;
    }
    return self;
}

#pragma mark - getter

-(UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        _addButton.userInteractionEnabled = NO;
    }
    return _addButton;
}

@end

NSString *kAddStickerCellIdentifier = @"kAddStickerCellIdentifier";

