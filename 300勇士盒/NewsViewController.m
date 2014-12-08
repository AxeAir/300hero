//
//  NewsViewController.m
//  300勇士盒
//
//  Created by ChenHao on 12/8/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "NewsViewController.h"
#import "UIViewController+CHSideMenu.h"
#import "UConstants.h"
#import "HYSegmentedControl.h"
#import "NewsTableViewController.h"

@interface NewsViewController ()

@property (nonatomic, strong) HYSegmentedControl *segment;
@property (nonatomic, strong) NewsTableViewController *news;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"最新资讯";
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1] forKey:NSForegroundColorAttributeName];
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"burger"] style:UIBarButtonItemStyleDone target:self action:@selector(toogleMenu)];
    self.navigationItem.leftBarButtonItem=left;
    [self.view  setBackgroundColor:BACKGROUND_COLOR];
    
    [self layout];
}


-(void)layout
{
    _segment=[[HYSegmentedControl alloc] initWithOriginY:0 Titles:@[@"头条", @"视频", @"补丁", @"靓照", @"囧途", @"壁纸"] delegate:self];
    [self.view addSubview:_segment];
    
//    _news=[[UITableView alloc] initWithFrame:CGRectMake(50, 0, Main_Screen_Width, 100) style:UITableViewStylePlain];
//    _news.dataSource=self;
//    _news.delegate=self;
//    [self.view addSubview:_news];
    _news=[[NewsTableViewController alloc] initWithHeader:NewsTypeHeader];
    
    [_news.tableView setFrame:CGRectMake(0, 30, Main_Screen_Width, Main_Screen_Height-30)];
    [self.view addSubview:_news.tableView];
    
}


- (void)toogleMenu
{
    [self.navigationController.sideMenuController toggleMenu:YES];
}






@end
