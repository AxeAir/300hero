//
//  AppDelegate.m
//  300勇士盒
//
//  Created by ChenHao on 10/4/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "CHSideMenu.h"
#import "SideMenuTableView.h"
#import "MainNavgationController.h"
#import "UConstants.h"
#import "NewsViewController.h"
#import "NewsNavViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#warning 请替换成自己的id和key 这样可以控制台中看到数据变化 https://cn.avoscloud.com/applist.html
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
    NewsViewController *contentController = [[NewsViewController alloc] init];
    
    NewsNavViewController *navController = [[NewsNavViewController alloc] initWithRootViewController:contentController];
    CHSideMenu *sideMenu = [[CHSideMenu alloc] initWithContentController:navController
                                                          menuController:menuController];
    self.window.rootViewController = sideMenu;
    
    
    
    
    return YES;
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
