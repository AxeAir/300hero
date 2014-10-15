//
//  ToolTableViewController.h
//  300勇士盒
//
//  Created by ChenHao on 10/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroViewController.h"
#import "SettingTableViewController.h"
@interface ToolTableViewController : UITableViewController

@property (nonatomic,strong) HeroViewController *hero;
@property (nonatomic,strong) SettingTableViewController *setting;
@end
