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
#import "RankTypeTableViewController.h"

#import "MainViewController.h"

#import "SettingNavViewController.h"
#import "SettingViewController.h"

#import "AboutNavViewController.h"
#import "AbountViewController.h"

#import "LXNavViewController.h"
#import "LXTableViewController.h"

#import "NewsNavViewController.h"
#import "NewsViewController.h"

#import "SearchViewController.h"

#import "HeroCollectionViewController.h"
#import "HeroNavViewController.h"

#import "RegisterLoginNavViewController.h"
#import "RegisterViewController.h"
@interface SideMenuTableView : UIViewController

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) SearchViewController *search;

@property (nonatomic,strong) MainViewController *main;

@property (nonatomic,strong) ToolNavgationController *toolNav;
@property (nonatomic,strong) ToolTableViewController *toolTable;

@property (nonatomic,strong) SettingNavViewController *settingNav;
@property (nonatomic,strong) SettingViewController *setting;

@property (nonatomic,strong) AboutNavViewController *aboutNav;
@property (nonatomic,strong) AbountViewController *about;

@property (nonatomic,strong) LXNavViewController *lxNav;
@property (nonatomic,strong) LXTableViewController *lxTable;

@property (nonatomic, strong) NewsNavViewController *newsnav;
@property (nonatomic, strong) NewsViewController *news;

@property (nonatomic, strong) HeroNavViewController *heroNav;
@property (nonatomic, strong) HeroCollectionViewController *hero;

@property (nonatomic, strong) RegisterLoginNavViewController *registerNav;
@property (nonatomic, strong) RegisterViewController *registerCV;

@property (nonatomic,strong) RankTypeTableViewController *rankTable;
@property (nonatomic,strong) MainViewController *other;


@end
