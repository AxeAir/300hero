//
//  DetailHero.m
//  300勇士盒
//
//  Created by ChenHao on 12/15/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "DetailHero.h"
#import "DetailSkill.h"
@implementation DetailHero

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _atk_type=[dic objectForKey:@"atk_type"];
        _desc=[dic objectForKey:@"desc"];
        _img=[dic objectForKey:@"img"];
        _name=[dic objectForKey:@"name"];
        _type=[dic objectForKey:@"type"];
        
        _atk=[[dic objectForKey:@"atk"] integerValue];
        _atk_gu=[[dic objectForKey:@"atk_gu"] integerValue];
        _cri=[[dic objectForKey:@"cri"] integerValue];
        _cri_gu=[[dic objectForKey:@"cri_gu"] integerValue];
        _dey=[[dic objectForKey:@"dey"] integerValue];
        _dey_gu=[[dic objectForKey:@"dey_gu"] integerValue];
        _dis=[[dic objectForKey:@"dis"] integerValue];
        _dis_gu=[[dic objectForKey:@"dis_gu"] integerValue];
        _free_type=[[dic objectForKey:@"free_type"] integerValue];
        _grp_rec=[[dic objectForKey:@"grp_rec"] integerValue];
        _hp=[[dic objectForKey:@"hp"] integerValue];
        _hp5=[[dic objectForKey:@"hp5"] integerValue];
        _hp_gu=[[dic objectForKey:@"hp_gu"] integerValue];
        _hp_rec=[[dic objectForKey:@"hp_rec"] integerValue];
        _heroid=[[dic objectForKey:@"heroid"] integerValue];
        _mov=[[dic objectForKey:@"mov"] integerValue];
        _mov_gu=[[dic objectForKey:@"mov_gu"] integerValue];
        _mp=[[dic objectForKey:@"mp"] integerValue];
        _mp5=[[dic objectForKey:@"mp5"] integerValue];
        _mp_gu=[[dic objectForKey:@"mp_gu"] integerValue];
        _mp_rec=[[dic objectForKey:@"mp_rec"] integerValue];
        _ope_rec=[[dic objectForKey:@"ope_rec"] integerValue];
        _psy_rec=[[dic objectForKey:@"psy_rec"] integerValue];
        _ref=[[dic objectForKey:@"ref"] integerValue];
        _ref_gu=[[dic objectForKey:@"ref_gu"] integerValue];
    
        DetailSkill *skill0=[[DetailSkill alloc] initWithDictionary:[dic objectForKey:@"skill0"]];
        DetailSkill *skill1=[[DetailSkill alloc] initWithDictionary:[dic objectForKey:@"skill1"]];
        DetailSkill *skill2=[[DetailSkill alloc] initWithDictionary:[dic objectForKey:@"skill2"]];
        DetailSkill *skill3=[[DetailSkill alloc] initWithDictionary:[dic objectForKey:@"skill3"]];
        DetailSkill *skill4=[[DetailSkill alloc] initWithDictionary:[dic objectForKey:@"skill4"]];
        
        _skills=[[NSArray alloc] initWithObjects:skill0,skill1,skill2,skill3,skill4, nil];
        
    }
    return self;
}

@end
