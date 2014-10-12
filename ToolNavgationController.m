//
//  ToolNavgationController.m
//  300勇士盒
//
//  Created by ChenHao on 10/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "ToolNavgationController.h"

@interface ToolNavgationController ()

@end

@implementation ToolNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor=[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:1];
    self.navigationBar.translucent=NO;

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
