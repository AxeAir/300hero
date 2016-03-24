//
//  MainNavgationController.m
//  300勇士盒
//
//  Created by ChenHao on 10/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "MainNavgationController.h"

@interface MainNavgationController ()

@end

@implementation MainNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor=[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:1];
    self.navigationBar.translucent=NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
