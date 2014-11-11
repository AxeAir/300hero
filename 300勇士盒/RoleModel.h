//
//  RoleModel.h
//  300勇士盒
//
//  Created by ChenHao on 10/13/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkillModel.h"
#import "EquipModel.h"
@interface RoleModel : NSObject

@property (nonatomic,strong) NSString   *RoleName;        // 角色名
@property (nonatomic,assign) NSUInteger RoleID;           // 角色ID
@property (nonatomic,assign) NSUInteger RoleLevel;        // 角色等级
@property (nonatomic,assign) NSUInteger HeroID;           // 英雄ID
@property (nonatomic,assign) NSUInteger HeroLevel;        // 英雄等级
@property (nonatomic,assign) NSUInteger Result;           // 比赛结果(1:胜利 2:失败 3:逃跑)
@property (nonatomic,assign) NSUInteger TeamResult;       // 团队比赛结果(1:胜利 0:失败)
@property (nonatomic,assign) NSUInteger IsFirstWin;       // 是否首胜(1:首胜)
@property (nonatomic,assign) NSUInteger KillCount;        // 击杀数
@property (nonatomic,assign) NSUInteger DeathCount;       // 死亡数
@property (nonatomic,assign) NSUInteger AssistCount;      // 助攻数
@property (nonatomic,assign) NSUInteger TowerDestroy;     // 建筑摧毁数
@property (nonatomic,assign) NSUInteger KillUnitCount;    // 小兵击杀数
@property (nonatomic,assign) NSUInteger TotalMoney;       // 金钱总数
@property (nonatomic,assign) NSUInteger RewardMoney;      // 金钱奖励
@property (nonatomic,assign) NSUInteger RewardExp;        // 经验奖励
@property (nonatomic,assign) NSInteger  JumpValue;         // 节操值
@property (nonatomic,assign) NSUInteger WinCount;         // 胜场数
@property (nonatomic,assign) NSUInteger MatchCount;       // 总场数
@property (nonatomic,assign) NSUInteger ELO;              // 团队(胜负)实力
@property (nonatomic,assign) NSInteger  KDA;              // 本场表现评分
// 英雄信息

@property (nonatomic,assign) NSUInteger ID;            // ID
@property (nonatomic,strong) NSString   *HeroName;        // 名称
@property (nonatomic,strong) NSString   *HeroIconFile;    // 图片相对路径.(在static/images/下)

@property (nonatomic,strong) NSArray *Skill;
@property (nonatomic,strong) NSArray *Equip;


-(id)initWithObject:(NSDictionary*)object;
@end
