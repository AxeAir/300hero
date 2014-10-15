//
//  MatchDetailModel.h
//  300勇士盒
//
//  Created by ChenHao on 10/13/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchDetailModel : NSObject

@property (nonatomic,assign) NSUInteger    MatchType;         // 比赛类型(1:竟技场 2:战场)
@property (nonatomic,assign) NSUInteger    WinSideKill;       // 胜利方杀人数
@property (nonatomic,assign) NSUInteger    LoseSideKill;      // 失败方杀人数
@property (nonatomic,assign) NSUInteger    UsedTime;          // 比赛所使用的时间(秒)
@property (nonatomic,strong) NSString      *MatchDate;       // 比赛日期

@property (nonatomic,strong) NSArray       *winSide;
@property (nonatomic,strong) NSArray       *loseSide;

- (void)parseFromObject:(NSDictionary*)object;

- (NSString*)getUseTime;
@end
