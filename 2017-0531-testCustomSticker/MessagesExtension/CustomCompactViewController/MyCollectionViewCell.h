//
//  MyCollectionViewCell.h
//  2017-0531-testCustomSticker
//
//  Created by 007 on 2017/5/31.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSSticker;

@interface MyCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)  MSSticker *sticker ;

@end


UIKIT_EXTERN NSString * kMyCollectionViewCellIdentifier ;

