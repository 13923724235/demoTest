//
//  AddStickerViewController.h
//  2017-0531-testCustomSticker
//
//  Created by 007 on 2017/5/31.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSSticker;

@protocol AddStickerViewControllerDelegate <NSObject>

@optional

- (void)addStickerViewControllerDidSelectSticker:(MSSticker *) sticker;

@end

@interface AddStickerViewController : UIViewController

@property (nonatomic, weak) id<AddStickerViewControllerDelegate> delegate ;

@end
