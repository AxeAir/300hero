//
//  MatchModel.h
//  300勇士盒
//
//  Created by ChenHao on 10/13/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchModel : NSObject

@property (nonatomic,assign) NSUInteger MatchID;       // 比赛ID
@property (nonatomic,assign) NSUInteger MatchType;     // 比赛类型(1:竟技场 2:战场)
@property (nonatomic,assign) NSUInteger HeroLevel;     // 英雄等级
@property (nonatomic,assign) NSUInteger Result;        // 比赛结果(1:胜利 2:失败 3:逃跑)
@property (nonatomic,strong) NSString   *MatchDate;    // 比赛日期

@property (nonatomic,assign) NSUInteger HeroID;         // ID
@property (nonatomic,strong) NSString   *HeroName;      // 名称
@property (nonatomic,strong) NSString   *HeroIconFile;  // 图片相对路径.(在static/images/下)


-(id)initWithDictionary:(NSDictionary *)dic;


@end
