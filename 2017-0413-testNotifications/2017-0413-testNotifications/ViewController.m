//
//  ViewController.m
//  2017-0413-testNotifications
//
//  Created by 007 on 2017/4/13.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

#import <AFNetworking.h>

#import "UNNotificationAttachment+CreateExtension.h"

@interface ViewController ()

    <
        UNUserNotificationCenterDelegate
    >

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",[NSLocale currentLocale]);
    
    NSLog(@"%@",[NSLocale preferredLanguages]);
    
    NSLog(@"%@",NSLocalizedString(@"Name_FORMAT", nil));

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self test10];
}


- (void)test10{

    NSString *picAttachMentIdentifier = @"picAttachMentIdentifier";
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMG_3836" ofType:@"JPG"]];
//    NSURL *mp3Url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp3"]];
    
    NSError *error ;
    
    UNNotificationAttachment *picAttachMent = [UNNotificationAttachment attachmentWithIdentifier:picAttachMentIdentifier URL:url options:nil error:&error];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
//    UNNotificationSound *sound = [UNNotificationSound soundNamed:@"sms-received1.caf"];
    
    content.title = @"hello world";
    content.subtitle = @"test notifications remove";
    content.body = @"Woah these new notifications look amazing! Don't you agree?";
//    content.sound = sound;
    
    [content setValue:@YES forKey:@"shouldAlwaysAlertWhileAppIsForeground"];
    
    NSString *launchImageName = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"png"];
    
    content.launchImageName = @"LaunchImage@2x";
    
    content.attachments = @[picAttachMent];
    
    content.categoryIdentifier = @"iOS10-category-identifier";
    
    UNTimeIntervalNotificationTrigger *timerTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5.0 repeats:NO];
    
    
    NSDateComponents *dateComos = [[NSDateComponents alloc] init];
    
    [dateComos setDay:10];
    [dateComos setMonth:6];
    [dateComos setYear:2017];
    [dateComos setHour:11];
    
//    UNCalendarNotificationTrigger *calendarTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComos repeats:YES];
//    
//    CLRegion *region ;
//    UNLocationNotificationTrigger *locationTrigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:YES];
    
    NSString *requestIdentifier = @"com.wkj.requestIdentifier";
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:timerTrigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {

    }];
    
//    [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[requestIdentifier]];
    
}

- (IBAction)updateNotificationContent:(id)sender {
    
    NSString *requestIdentifier = @"com.wkj.requestIdentifier";

    UNMutableNotificationContent *newContent = [[UNMutableNotificationContent alloc] init];

    UNNotificationSound *newSound = [UNNotificationSound defaultSound];

    newContent.title = @"update hello world update";
    newContent.subtitle = @"update test notifications update";
    newContent.body = @"update Woah these new notifications look amazing! Don't you agree?";
    newContent.sound = newSound;

    UNTimeIntervalNotificationTrigger *newTimerTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5.0 repeats:NO];

    UNNotificationRequest *newRequest = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:newContent trigger:newTimerTrigger];

    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:newRequest withCompletionHandler:^(NSError * _Nullable error) {
        
        NSLog(@"添加更新推送失败：%@",error);
    }];
    
}


- (void)testLocal{
    UILocalNotification *note = [[UILocalNotification alloc] init];
    
    note.applicationIconBadgeNumber = 3;
    note.alertBody = @"test body";
    note.alertTitle = @"test title";
    
    note.category = @"test-replay";  // test-replay test-like
    
    note.hasAction = YES;
    note.alertAction = @"123";
    
    note.soundName = @"test.aiff";
    //    note.soundName = UILocalNotificationDefaultSoundName;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComos = [[NSDateComponents alloc] init];
    
    [dateComos setDay:10];
    [dateComos setMonth:6];
    [dateComos setYear:2017];
    [dateComos setHour:11];
    
    //    note.fireDate = [calendar dateFromComponents:dateComos];
    note.fireDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
    
    note.timeZone = [calendar timeZone];
    
    //    note.repeatInterval = NSCalendarUnitDay; // 每天
    /*
     NSCalendarUnitEra                ,
     NSCalendarUnitYear               ,
     NSCalendarUnitMonth              ,
     NSCalendarUnitDay                ,
     NSCalendarUnitHour               ,
     NSCalendarUnitMinute             ,
     NSCalendarUnitSecond             ,
     NSCalendarUnitWeekday            ,
     NSCalendarUnitWeekdayOrdinal     ,
     NSCalendarUnitQuarter            ,
     NSCalendarUnitWeekOfMonth        ,
     NSCalendarUnitWeekOfYear         ,
     NSCalendarUnitYearForWeekOfYear  ,
     NSCalendarUnitNanosecond         ,
     NSCalendarUnitCalendar           ,
     NSCalendarUnitTimeZone
     */
    
    //    note.repeatCalendar = [NSCalendar currentCalendar];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
    
    //    [[UIApplication sharedApplication] presentLocalNotificationNow:note];
    
    
    //    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


@end
