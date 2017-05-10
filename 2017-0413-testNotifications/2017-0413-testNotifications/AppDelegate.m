//
//  AppDelegate.m
//  2017-0413-testNotifications
//
//  Created by 007 on 2017/4/13.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>

#import "ViewController.h"

@interface AppDelegate ()

    <
        UNUserNotificationCenterDelegate
    >

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
    }];
    
#pragma mark - iOS10 注册action
    
    UNNotificationAction *action = [UNNotificationAction actionWithIdentifier:@"iOS10-删除" title:@"删除" options:UNNotificationActionOptionDestructive];
    
    UNTextInputNotificationAction *textInputNotificationAction = [UNTextInputNotificationAction actionWithIdentifier:@"iOS10-replay" title:@"回复" options:UNNotificationActionOptionAuthenticationRequired textInputButtonTitle:@"test" textInputPlaceholder:@"placeholder"];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"iOS10-category-identifier" actions:@[action , textInputNotificationAction] intentIdentifiers:nil options:UNNotificationCategoryOptionCustomDismissAction];
    
    NSSet *set = [NSSet setWithObject:category];
    
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:set];
    
#pragma mark - 打印推送内容
    
//    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    
//    self.window.rootViewController = [[ViewController alloc] init];
//    
//    [self.window makeKeyAndVisible];
//    
//    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    
//    label.numberOfLines = 0;
//    
//    label.text = [NSString stringWithFormat:@"%@",userInfo];
//    label.backgroundColor = [UIColor brownColor];
//    
//    if (userInfo) {
//        [self.window addSubview:label];
//
//    }
//    
//    NSDictionary *userInfoLocal = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
//    
//    if (userInfoLocal) {
//        label.text = [NSString stringWithFormat:@"%@",userInfoLocal];
//        [self.window addSubview:label];
//    }
    
#pragma mark - 注册action

//    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
//    
//    action.title = @"回复";
//    action.identifier = @"test-replay-action";
//    action.activationMode = UIUserNotificationActivationModeBackground;
//    action.authenticationRequired = YES;
//    action.behavior = UIUserNotificationActionBehaviorTextInput; // UIUserNotificationActionBehaviorDefault
//    
//    
//    
//    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
//    
//    action2.title = @"点赞";
//    action2.identifier = @"test_close_action";
//    action2.activationMode = UIUserNotificationActivationModeBackground;
//    action2.authenticationRequired = YES;
//    action2.behavior = UIUserNotificationActionBehaviorTextInput; // UIUserNotificationActionBehaviorTextInput
//
//    
//    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
//    category.identifier = @"test-replay";
//    [category setActions:@[action] forContext:UIUserNotificationActionContextDefault];
//    
//    
//    UIMutableUserNotificationCategory *category2 = [[UIMutableUserNotificationCategory alloc] init];
//    category2.identifier = @"test-close";
//    [category2 setActions:@[action2] forContext:UIUserNotificationActionContextDefault];
//    
//    
//    NSSet *set = [NSSet setWithObjects:category, nil];
//    
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:set];
//    
//    [application registerUserNotificationSettings:settings];
//    [application registerForRemoteNotifications];
    
#pragma mark - 极光设置
    
//    if ( 10 > [[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        //可以添加自定义categories
//        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                          UIUserNotificationTypeSound |
//                                                          UIUserNotificationTypeAlert)
//                                              categories:nil];
//    }
//    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
//        
//        JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
//        
//        entity.types = JPAuthorizationOptionBadge | JPAuthorizationOptionSound | JPAuthorizationOptionAlert;
//        
//        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//    }
//    else {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//        //categories 必须为nil
//        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                          UIRemoteNotificationTypeSound |
//                                                          UIRemoteNotificationTypeAlert)
//                                              categories:nil];
//#pragma clang diagnostic pop
//    }
    //Required
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
//    [JPUSHService setupWithOption:launchOptions appKey:@"d762fff353708e67a59eb8b2"
//                          channel:@"App Store"
//                 apsForProduction:0];
//    
//    //上线后关掉日志打印
//    [JPUSHService setLogOFF];
    
    
    return YES;
}

#pragma mark - JPUSHRegisterDelegate

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler{
    
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    NSLog(@"push notification userinfo : %@",response);

}


#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    UNNotificationPresentationOptions presentationOptions = UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge;

    completionHandler(presentationOptions);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    
//    response = (UNTextInputNotificationResponse *) response;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    label.numberOfLines = 0;
    
    label.text = [NSString stringWithFormat:@"%@",[(UNTextInputNotificationResponse *) response userText]];
    label.backgroundColor = [UIColor orangeColor];
    
    [self.window addSubview:label];
    
    completionHandler();
}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    NSLog(@"推送消息===%@",userInfo);
    
    application.applicationIconBadgeNumber = 0;
    
    //提交服务器，设置badge为0
    //[JPUSHService setBadge:0];
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    //处理传过来的推送消息
    
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    
//    NSLog(@"push notification userinfo : %@",userInfo);
//    
//    //清除角标
//    application.applicationIconBadgeNumber = 0;
//    
//    //[JPUSHService setBadge:0];
//    
//    // IOS 7 Support Required
//    [JPUSHService handleRemoteNotification:userInfo];
//    
//    completionHandler(UIBackgroundFetchResultNewData);
//    
//    //处理传过来的推送消息
//}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"%@",notification.userInfo);
}



- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler {
    
    
    NSLog(@"identifier---%@---notification---%@",identifier,notification);
    
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    
    
    NSLog(@"identifier---%@---notification---%@---responseInfo---%@",identifier,notification,responseInfo);

}



- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    
    
    NSLog(@"identifier---%@---userInfo---%@---responseInfo---%@",identifier,userInfo,responseInfo);
}


- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler {
    NSLog(@"identifier---%@---userInfo---%@",identifier,userInfo);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSLog(@"applicationDidEnterBackground-%@",application);

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    NSLog(@"applicationWillEnterForeground-%@",application);

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    NSLog(@"applicationDidBecomeActive-%@",application);

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSLog(@"applicationWillTerminate-%@",application);

}


@end
