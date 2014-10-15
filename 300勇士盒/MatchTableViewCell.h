//
//  MatchTableViewCell.h
//  300勇士盒
//
//  Created by ChenHao on 10/13/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchModel.h"
@interface MatchTableViewCell : UITableViewCell
@property (nonatomic,assign) NSUInteger MatchID;

@property (nonatomic,strong) UILabel *type;
@property (nonatomic,strong) UILabel *result;

-(void)config:(MatchModel*)model;
@end
