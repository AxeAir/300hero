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
#import "HeaderScrollView.h"
#import "NewsTableViewCell.h"

@interface NewsViewController ()<HYSegmentedControlDelegate>

@property (nonatomic, strong) HYSegmentedControl *segment;
@property (nonatomic, strong) NewsTableViewController *news;

@property (nonatomic, strong) HeaderScrollView *header;

@property (nonatomic, assign) NSInteger cuuentSegment;

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
    _cuuentSegment = 0;
    _segment=[[HYSegmentedControl alloc] initWithOriginY:0 Titles:@[@"头条", @"视频", @"补丁", @"靓照", @"囧途", @"壁纸"] delegate:self];
    [self.view addSubview:_segment];
    
    _news=[[NewsTableViewController alloc] initWithHeader:NewsTypeHeader];
    [_news.tableView setFrame:CGRectMake(0, 40, Main_Screen_Width, Main_Screen_Height-40)];
    
    [self.view addSubview:_news.tableView];
    
}






-(void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    NSLog(@"%d",index);
    
    if (index==_cuuentSegment) {
    
    }
    else
    {
        [_news.tableView removeFromSuperview];
        switch (index) {
            case 0:
            {
                _news=[[NewsTableViewController alloc] initWithHeader:NewsTypeHeader];
                
                
            }
                break;
            case 1:
            {
                _news=[[NewsTableViewController alloc] initWithHeaderWithoutHeader:NewsTypeHeader];
                
            }
                break;
                
            case 2:
            {
                _news=[[NewsTableViewController alloc] initWithHeaderWithoutHeader:NewsTypeHeader];
                
            }
                break;
                
            case 3:
            {
                _news=[[NewsTableViewController alloc] initWithHeaderWithoutHeader:NewsTypeHeader];
                
            }
                break;
                
            default:
                break;
        }
        _cuuentSegment=index;
        [_news.tableView setFrame:CGRectMake(0, 40, Main_Screen_Width, Main_Screen_Height-40)];
        
        [self.view addSubview:_news.tableView];
        
    }
}



- (void)toogleMenu
{
    [self.navigationController.sideMenuController toggleMenu:YES];
}









@end
