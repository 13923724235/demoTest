//
//  NotificationService.m
//  2017-0509-notificationService
//
//  Created by 007 on 2017/5/9.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "NotificationService.h"
#import <UIKit/UIKit.h>
#import "UNNotificationAttachment+CreateExtension.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
//    NSDictionary *userInfo = request.content.userInfo;
//    
//    NSString *encryptionContent = userInfo[@"encryption"];
//    
//    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", encryptionContent];
    
    UNMutableNotificationContent *content = [self.bestAttemptContent mutableCopy];
    
    NSURL *imageUrl = [NSURL URLWithString:@"http://upload-images.jianshu.io/upload_images/1159656-22419f571bb4bcd9.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:imageUrl completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSLog(@"Downloading notification attachment completed with %@", error == nil ? @"success" : [NSString stringWithFormat:@"error: %@", error]);
        
        NSError *fileError;
        // create a local URL with extension
        NSURL *urlWithExtension = [NSURL fileURLWithPath:[location.path stringByAppendingString:imageUrl.lastPathComponent]];
        
        if (![[NSFileManager defaultManager] moveItemAtURL:location toURL:urlWithExtension error:&fileError]) {
            NSLog(@"Could not append  local attachment file name: %@", fileError);
            contentHandler(content);
            return;
        }
        
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:imageUrl.absoluteString
                                                                                              URL:urlWithExtension options:nil
                                                                                            error:&fileError];
        
        if (!attachment) {
            NSLog(@"Could not create local attachment file: %@", fileError);
            contentHandler(content);
            return;
        }
        
        NSLog(@"Adding attachment: %@", attachment);
        
        NSMutableArray *attachments = content.attachments ? [content.attachments mutableCopy] : [NSMutableArray array];
        
        [attachments addObject:attachment];
        
        content.attachments = attachments;
        
        contentHandler(content);
        
    }];
    [task resume];
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
