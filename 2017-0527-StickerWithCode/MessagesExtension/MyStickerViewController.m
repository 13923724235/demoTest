//
//  MyStickerViewController.m
//  2017-0527-StickerWithCode
//
//  Created by 007 on 2017/5/31.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "MyStickerViewController.h"

@interface MyStickerViewController ()

@property (nonatomic, strong) NSMutableArray *stickersArrayM ;

@end

@implementation MyStickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.58 blue:0.68 alpha:1.0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - MSStickerBrowserViewDataSource

- (NSInteger)numberOfStickersInStickerBrowserView:(MSStickerBrowserView *)stickerBrowserView{
    return self.stickersArrayM.count;
}

- (MSSticker *)stickerBrowserView:(MSStickerBrowserView *)stickerBrowserView stickerAtIndex:(NSInteger)index{
    
    return self.stickersArrayM[index];
}

#pragma mark - getter

-(NSMutableArray *)stickersArrayM{
    if (!_stickersArrayM) {
        _stickersArrayM = [NSMutableArray array];
        
        for (int i = 1; i < 6; i ++) {
            
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
