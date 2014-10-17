//
//  MatchDetailViewController.h
//  300勇士盒
//
//  Created by ChenHao on 10/13/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherViewController.h"
@interface MatchDetailViewController : UIViewController

@property (nonatomic,assign) NSUInteger MatchID;
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) OtherViewController *other;

@end
