//
//  MatchDetailView.h
//  300勇士盒
//
//  Created by ChenHao on 10/14/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoleModel.h"
@protocol MatchDeailViewDelegate

-(void)didClickHeaderView:(NSString*)name;

@end

@interface MatchDetailView : UIView
-(void)configView:(RoleModel*)role;

@property (nonatomic,weak) id<MatchDeailViewDelegate> delegate;
@end


