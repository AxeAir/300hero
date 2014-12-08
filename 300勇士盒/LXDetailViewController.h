//
//  LXDetailViewController.h
//  300勇士盒
//
//  Created by ChenHao on 10/22/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherViewController.h"
@interface LXDetailViewController : UIViewController

@property (nonatomic,assign) NSInteger ID;

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) OtherViewController *other;




@end
