//
//  AppDelegate.m
//  300勇士盒
//
//  Created by ChenHao on 10/4/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "AppDelegate.h"
#import "CHSideMenu.h"
#import "SideMenuTableView.h"
#import "UConstants.h"
#import "MainViewController.h"
#import "MainNavgationController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>
#import <AVOSCloud/AVInstallation.h>
#import <AVOSCloudSNS/AVUser+SNS.h>
#define AVOSCloudAppID  @"tiyml8544dd5u6ieukgdvdncay59ay2xqyx200wjvpmpe7a5"
#define AVOSCloudAppKey @"q7jph42jjonnvkizxnsan97ovsi72spz2p6ol4nxfej8xyxg"
@interface AppDelegate ()

@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置AVOSCloud
    [AVOSCloud setApplicationId:AVOSCloudAppID
                      clientKey:AVOSCloudAppKey];
    
    
    //统计应用启动情况
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    SideMenuTableView *menuController = [[SideMenuTableView alloc] init];
    MainViewController * main = [[MainViewController alloc] init];
    MainNavgationController *manNav = [[MainNavgationController alloc] initWithRootViewController:main];
    CHSideMenu *sideMenu = [[CHSideMenu alloc] initWithContentController:manNav
                                                          menuController:menuController];
    self.window.rootViewController = sideMenu;
    
    //ios7
    
    if (FSystenVersion>=8.0) {
        //IOS8
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert
                                                | UIUserNotificationTypeBadge
                                                | UIUserNotificationTypeSound
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
    }
    return YES;
}



-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [AVOSCloudSNS handleOpenURL:url];
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
    NSString* dt = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSLog(@"deviceToken:%@", dt);
}

-  (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%@",error);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
