
//
//  MainViewController.h
//  300勇士盒
//
//  Created by ChenHao on 10/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface MainViewController : UIViewController

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UITextField *searchName;

@property (nonatomic,strong) UITableView *recentMatch;

@property (nonatomic,strong) UILabel *KDALabelTitle;
@property (nonatomic,strong) UILabel *KDALabel;
@property (nonatomic,strong) UILabel *KDADetail;
@property (nonatomic,strong) UILabel *wincount;
@property (nonatomic,strong) UILabel *losecount;

@property (nonatomic,strong) UIView *KDA;
@property (nonatomic,strong) UILabel *ALLLabelTitle;
@property (nonatomic,strong) UILabel *ALLcount;
@property (nonatomic,strong) UILabel *ALLwincount;
@property (nonatomic,strong) UILabel *ALLlosecount;

@property (nonatomic,strong) UILabel *combat;

@property (nonatomic,strong) SearchViewController *searchView;
@property (nonatomic,strong) UIActivityIndicatorView *LodingActivityIndicator;

@property (nonatomic,strong) UIView *buttonGroup;

@property (nonatomic,strong) UIView *mask;


@end
