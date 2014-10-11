//
//  SideMenuTableView.h
//  300勇士盒
//
//  Created by ChenHao on 10/7/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolNavgationController.h"
#import "ToolTableViewController.h"
#import "RankNavController.h"
#import "RankTypeTableViewController.h"

#import "SearchViewController.h"
@interface SideMenuTableView : UIViewController

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) SearchViewController *search;



@property (nonatomic,strong) ToolNavgationController *toolNav;
@property (nonatomic,strong) ToolTableViewController *toolTable;

@property (nonatomic,strong) RankNavController *rankNav;
@property (nonatomic,strong) RankTypeTableViewController *rankTable;
@end
