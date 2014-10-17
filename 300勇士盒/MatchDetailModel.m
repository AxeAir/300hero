//
//  MatchDetailModel.m
//  300勇士盒
//
//  Created by ChenHao on 10/13/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "MatchDetailModel.h"
#import "RoleModel.h"


@implementation MatchDetailModel

-(void)parseFromObject:(NSDictionary *)object
{
    _MatchType=[[object objectForKey:@"MatchType"] integerValue];
    _WinSideKill=[[object objectForKey:@"WinSideKill"] integerValue];
    _LoseSideKill=[[object objectForKey:@"LoseSideKill"] integerValue];
    _UsedTime=[[object objectForKey:@"UsedTime"] integerValue];
    _MatchDate=[object objectForKey:@"MatchDate"];
    
    NSArray *win=[object objectForKey:@"WinSide"];
    NSMutableArray *MuWinSide=[[NSMutableArray alloc] init];
    for (NSDictionary *role in win) {
        RoleModel *model=[[RoleModel alloc] initWithObject:role];
        [MuWinSide addObject:model];
    }
    
    _winSide=MuWinSide;
    
    NSArray *lose=[object objectForKey:@"LoseSide"];
    NSMutableArray *MuLoseSide=[[NSMutableArray alloc] init];
    for (NSDictionary *role in lose) {
        RoleModel *model=[[RoleModel alloc] initWithObject:role];
        [MuLoseSide addObject:model];
    }
    
    _loseSide=MuLoseSide;
    
    
}

-(NSString*)getUseTime
{
    return [NSString stringWithFormat:@"游戏耗时:%u分%u秒",_UsedTime/60,_UsedTime%60];
}
@end
