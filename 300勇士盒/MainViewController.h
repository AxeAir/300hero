
//
//  MainViewController.h
//  300勇士盒
//
//  Created by ChenHao on 10/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface MainViewController : UIViewController

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UITextField *searchName;

@property (nonatomic,strong) UITableView *recentMatch;

@property (nonatomic,strong) UIView  *KDA;
@property (nonatomic,strong) UILabel *ALLLabelTitle;
@property (nonatomic,strong) UILabel *ALLcount;
@property (nonatomic,strong) UILabel *ALLwincount;
@property (nonatomic,strong) UILabel *ALLlosecount;
@property (nonatomic,strong) UILabel *name;

@property (nonatomic,strong) UILabel *combat;

@property (nonatomic,strong) UIActivityIndicatorView *LodingActivityIndicator;

@property (nonatomic,strong) UIView *buttonGroup;

@property (nonatomic,strong) UIView *mask;


- (instancetype)initWithOtherHero:(NSString *)name;

@end
