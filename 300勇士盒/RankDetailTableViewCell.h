//
//  RankDetailTableViewCell.h
//  300勇士盒
//
//  Created by ChenHao on 10/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankDetailModel.h"
@interface RankDetailTableViewCell : UITableViewCell

@property (nonatomic,strong) NSString *rolename;
-(void)configCell:(RankDetailModel*)model;
-(void)configLXCell:(RankDetailModel *)model type:(NSString *)type;
@end
