//
//  MyCustomCompactViewController.h
//  2017-0531-testCustomSticker
//
//  Created by 007 on 2017/5/31.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSSticker;

@protocol MyCustomCompactViewControllerDelegate <NSObject>

@optional

- (void)myCustomCompactViewControllerDidSelectAddOtherStickerItem;

@end

@interface MyCustomCompactViewController : UIViewController

@property (nonatomic, weak) id<MyCustomCompactViewControllerDelegate> delegate ;

- (void)addNewSticker:(MSSticker *) sticker;

@end
