//
//  SearchViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UISearchBarDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    UISearchBar *bar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    bar.backgroundImage=[UIImage imageNamed:@"background101020.png"];
    bar.backgroundColor=[UIColor redColor];
    bar.delegate=self;
    bar.showsCancelButton=YES;
    bar.showsScopeBar=YES;
    bar.scopeButtonTitles = [NSArray arrayWithObjects:@"人",@"英雄",@"装备",nil];
    [self.view addSubview:bar];
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
