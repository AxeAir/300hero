//
//  MatchDetailView.m
//  300勇士盒
//
//  Created by ChenHao on 10/14/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "MatchDetailView.h"
#import "EquipModel.h"
#import <UIImageView+WebCache.h>

@implementation MatchDetailView

- (void)configView:(RoleModel *)role
{
    UIImageView *header=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://300report.jumpw.com/static/images/%@",role.HeroIconFile]];
    [header sd_setImageWithURL:url];
    [self addSubview:header];
    
    UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(70, 0, 180, 40)];
    name.text=role.RoleName;
    [self addSubview:name];
    
    int i=0;
    for (EquipModel *equip in role.Equip) {
        
        UIImageView *header=[[UIImageView alloc] initWithFrame:CGRectMake(70+30*i, 35, 25, 25)];
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://300report.jumpw.com/static/images/%@",equip.IconFile]];
        [header sd_setImageWithURL:url];
        [self addSubview:header];
        i++;
    }
    
    UILabel *TotalMoney=[[UILabel alloc] initWithFrame:CGRectMake(10, 60, 100, 30)];
    TotalMoney.text=[NSString stringWithFormat:@"获得金钱 %lu",(unsigned long)role.TotalMoney];
    TotalMoney.font=[UIFont systemFontOfSize:12];
    [self addSubview:TotalMoney];
    
    UILabel *KillUnitCount=[[UILabel alloc] initWithFrame:CGRectMake(10, 80, 100, 30)];
    KillUnitCount.text=[NSString stringWithFormat:@"小兵击杀数 %lu",(unsigned long)role.KillUnitCount];
    KillUnitCount.font=[UIFont systemFontOfSize:12];
    [self addSubview:KillUnitCount];
    
    UILabel *TowerDestroy=[[UILabel alloc] initWithFrame:CGRectMake(100, 60, 100, 30)];
    TowerDestroy.text=[NSString stringWithFormat:@"建筑摧毁数 %lu",(unsigned long)role.TowerDestroy];
    TowerDestroy.font=[UIFont systemFontOfSize:12];
    [self addSubview:TowerDestroy];
    
 
}

@end
