//
//  SearchViewController.h
//  300勇士盒
//
//  Created by ChenHao on 10/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (nonatomic,strong) UISearchBar *bar;
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIActivityIndicatorView *LodingActivityIndicator;

@end
