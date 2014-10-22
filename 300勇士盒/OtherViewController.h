//
//  OtherViewController.h
//  300勇士盒
//
//  Created by ChenHao on 10/17/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherViewController : UIViewController

-(id)initWithName:(NSString*)roleName;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UITextField *searchName;

@property (nonatomic,strong) UITableView *recentMatch;

@property (nonatomic,strong) UILabel *KDALabelTitle;
@property (nonatomic,strong) UILabel *KDALabel;
@property (nonatomic,strong) UILabel *KDADetail;
@property (nonatomic,strong) UILabel *wincount;
@property (nonatomic,strong) UILabel *losecount;


@property (nonatomic,strong) UILabel *ALLLabelTitle;
@property (nonatomic,strong) UILabel *ALLcount;
@property (nonatomic,strong) UILabel *ALLwincount;
@property (nonatomic,strong) UILabel *ALLlosecount;

@property (nonatomic,strong) UILabel *combat;
@end
