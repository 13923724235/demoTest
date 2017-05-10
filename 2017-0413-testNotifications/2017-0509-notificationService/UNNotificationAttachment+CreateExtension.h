//
//  UNNotificationAttachment+CreateExtension.h
//  2017-0413-testNotifications
//
//  Created by 007 on 2017/5/10.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>

@interface UNNotificationAttachment (CreateExtension)


+ (instancetype)createAttachmentWithImageFileIdentifier:(NSString *) imageFileIdentifier data:(NSData *) data ;

@end
