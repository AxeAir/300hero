//
//  ViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/4/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+CHSideMenu.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"burger"] style:UIBarButtonItemStyleDone target:self action:@selector(toogleMenu)];
    self.navigationItem.leftBarButtonItem=left;
   
    self.view.backgroundColor=[UIColor whiteColor];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)toogleMenu
{
    [self.navigationController.sideMenuController toggleMenu:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
