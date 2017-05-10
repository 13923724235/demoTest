//
//  UNNotificationAttachment+CreateExtension.m
//  2017-0413-testNotifications
//
//  Created by 007 on 2017/5/10.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "UNNotificationAttachment+CreateExtension.h"

#import <UIKit/UIKit.h>

@implementation UNNotificationAttachment (CreateExtension)

+ (instancetype)createAttachmentWithImageFileIdentifier:(NSString *) imageFileIdentifier data:(NSData *) data {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *tmpSubFolderName = NSProcessInfo.processInfo.globallyUniqueString;
    
    NSURL *tmpSubFolderURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:tmpSubFolderName isDirectory:YES];
    
    [fileManager createDirectoryAtURL:tmpSubFolderURL withIntermediateDirectories:YES attributes:nil error:NULL];
    
    NSURL *fileURL = [tmpSubFolderURL URLByAppendingPathComponent:imageFileIdentifier];
    
    [data writeToURL:fileURL options:0 error:NULL];
    
    NSError *error ;
    
    UNNotificationAttachment *imageAttachment = [UNNotificationAttachment attachmentWithIdentifier:imageFileIdentifier URL:fileURL options:nil error:&error];
    
    NSLog(@"error:%@",error);
    
    return imageAttachment;
}

@end
