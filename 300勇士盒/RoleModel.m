//
//  RoleModel.m
//  300勇士盒
//
//  Created by ChenHao on 10/13/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "RoleModel.h"

@implementation RoleModel

-(id)initWithObject:(NSDictionary *)object
{
    self=[super init];
    if(self)
    {
        _RoleName=[object objectForKey:@"RoleName"];
        _RoleID=[[object objectForKey:@"RoleID"] integerValue];
        _RoleLevel=[[object objectForKey:@"RoleLevel"] integerValue];
        _HeroID=[[object objectForKey:@"HeroID"] integerValue];
        _HeroLevel=[[object objectForKey:@"HeroLevel"] integerValue];
        _Result=[[object objectForKey:@"Result"] integerValue];
        _TeamResult=[[object objectForKey:@"TeamResult"] integerValue];
        _IsFirstWin=[[object objectForKey:@"IsFirstWin"] integerValue];
        _KillCount=[[object objectForKey:@"KillCount"] integerValue];
        _DeathCount=[[object objectForKey:@"DeathCount"] integerValue];
        _AssistCount=[[object objectForKey:@"AssistCount"] integerValue];
        _TowerDestroy=[[object objectForKey:@"TowerDestroy"] integerValue];
        _KillUnitCount=[[object objectForKey:@"KillUnitCount"] integerValue];
        _TotalMoney=[[object objectForKey:@"TotalMoney"] integerValue];
        _RewardMoney=[[object objectForKey:@"RewardMoney"] integerValue];
        _RewardExp=[[object objectForKey:@"RewardExp"] integerValue];
        _JumpValue=[[object objectForKey:@"JumpValue"] integerValue];
        _WinCount=[[object objectForKey:@"WinCount"] integerValue];
        _MatchCount=[[object objectForKey:@"MatchCount"] integerValue];
        _ELO=[[object objectForKey:@"ELO"] integerValue];
        _KDA=[[object objectForKey:@"KDA"] integerValue];
        
        NSDictionary *hero=[object objectForKey:@"Hero"];
        
        _HeroID=[[hero objectForKey:@"ID"] integerValue];
        _HeroName=[hero objectForKey:@"Name"];
        _HeroIconFile=[hero objectForKey:@"IconFile"];
        
        
        NSArray *EquipTemp=[object objectForKey:@"Equip"];
        NSMutableArray *EquipData=[[NSMutableArray alloc] init];
        
        for (NSDictionary *eq in EquipTemp) {
            EquipModel *model=[[EquipModel alloc] init];
            model.ID=[[eq objectForKey:@"ID"] integerValue];
            model.IconFile=[eq objectForKey:@"IconFile"];
            model.Name=[eq objectForKey:@"Name"];
            [EquipData addObject:model];
        }
        
        _Equip=EquipData;
        
        NSArray *SkillTemp=[object objectForKey:@"Skill"];
        NSMutableArray *SkillData=[[NSMutableArray alloc] init];
        
        for (NSDictionary *sk in SkillTemp) {
            SkillModel *model=[[SkillModel alloc] init];
            model.ID=[[sk objectForKey:@"ID"] integerValue];
            model.IconFile=[sk objectForKey:@"IconFile"];
            model.Name=[sk objectForKey:@"Name"];
            [SkillData addObject:model];
        }
        
        _Skill=SkillData;
    }
    return self;
}

@end
