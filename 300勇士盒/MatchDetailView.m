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
#import "HeaderButton.h"
#import "UConstants.h"
@implementation MatchDetailView

- (void)configView:(RoleModel *)role
{
    [self setUserInteractionEnabled:YES];
    UIImageView *header=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://300report.jumpw.com/static/images/%@",role.HeroIconFile]];
    [header sd_setImageWithURL:url];
    
    HeaderButton *button=[[HeaderButton alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    button.rolename=role.RoleName;
    [self addSubview:button];
    [self addSubview:header];
    
    UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(70, 0, 180, 40)];
    name.text=[NSString stringWithFormat:@"%@ (LV.%d)",role.RoleName,role.RoleLevel];
    name.textColor=RGBCOLOR(226, 191, 20);
    [self addSubview:name];
    
    
    UILabel *KDA=[[UILabel alloc] initWithFrame:CGRectMake(250, 5, 70, 30)];
    KDA.text=[NSString stringWithFormat:@"%d/%d/%d",role.KillCount,role.DeathCount,role.AssistCount];
    KDA.textColor=[UIColor redColor];
    [self addSubview:KDA];
    
    int i=0;
    for (EquipModel *equip in role.Equip) {
        
        UIImageView *header=[[UIImageView alloc] initWithFrame:CGRectMake(70+30*i, 35, 25, 25)];
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://300report.jumpw.com/static/images/%@",equip.IconFile]];
        [header sd_setImageWithURL:url];
        [self addSubview:header];
        i++;
    }
    
    i=0;
    {
        for(SkillModel *skill in role.Skill)
        {
            UIImageView *header=[[UIImageView alloc] initWithFrame:CGRectMake(260+30*i, 35, 25, 25)];
            NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://300report.jumpw.com/static/images/%@",skill.IconFile]];
            [header sd_setImageWithURL:url];
            [self addSubview:header];
            i++;
        }
    }
    
    UILabel *TotalMoney=[[UILabel alloc] initWithFrame:CGRectMake(10, 60, 100, 30)];
    TotalMoney.text=[NSString stringWithFormat:@"获得金钱 %lu",(unsigned long)role.TotalMoney];
    TotalMoney.font=[UIFont systemFontOfSize:12];
    TotalMoney.textColor=RGBCOLOR(136, 187, 225);
    [self addSubview:TotalMoney];
    
    UILabel *KillUnitCount=[[UILabel alloc] initWithFrame:CGRectMake(10, 80, 100, 30)];
    KillUnitCount.text=[NSString stringWithFormat:@"小兵击杀数 %lu",(unsigned long)role.KillUnitCount];
    KillUnitCount.font=[UIFont systemFontOfSize:12];
    KillUnitCount.textColor=RGBCOLOR(136, 187, 225);
    [self addSubview:KillUnitCount];
    
    UILabel *TowerDestroy=[[UILabel alloc] initWithFrame:CGRectMake(100, 60, 100, 30)];
    TowerDestroy.text=[NSString stringWithFormat:@"建筑摧毁数 %lu",(unsigned long)role.TowerDestroy];
    TowerDestroy.font=[UIFont systemFontOfSize:12];
    TowerDestroy.textColor=RGBCOLOR(136, 187, 225);
    [self addSubview:TowerDestroy];
    
    UILabel *bx=[[UILabel alloc] initWithFrame:CGRectMake(100, 80, 150, 30)];
    bx.text=[NSString stringWithFormat:@"本场表现分:%d",role.KDA];
    bx.font=[UIFont systemFontOfSize:12];
    bx.textColor=RGBCOLOR(136, 187, 225);
    [self addSubview:bx];
    
 
}

-(void)click:(id)sender
{
    HeaderButton *button=(HeaderButton*)sender;
    [_delegate didClickHeaderView:button.rolename];
}


@end
