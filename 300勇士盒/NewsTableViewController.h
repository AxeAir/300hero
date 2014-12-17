//
//  NewsTableViewController.h
//  300勇士盒
//
//  Created by ChenHao on 12/8/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NewsTypeHeader 0
#define NewsTypeBD 2
#define NewsTypeVIDEO 1
#define NewsTypeHELP 3


@protocol NewsTableViewControllerDelegate;


@interface NewsTableViewController : UITableViewController


- (instancetype)initWithHeader:(NSInteger)NewsType;
- (instancetype)initWithHeaderWithoutHeader:(NSInteger)NewsType;

@property (nonatomic, weak) id<NewsTableViewControllerDelegate> delegate;
@end


@protocol NewsTableViewControllerDelegate

- (void)clickcell2web:(NSInteger)pageID;

@end