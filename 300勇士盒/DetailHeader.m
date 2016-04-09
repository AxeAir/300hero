//
//  DetailHeader.m
//  300勇士盒
//
//  Created by ChenHao on 12/15/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "DetailHeader.h"
#import <UIImageView+WebCache.h>
#import "UConstants.h"

@interface DetailHeader()


@property (nonatomic, strong) DetailHero *hero;
@property (nonatomic, strong) UIImageView *header;
@property (nonatomic, strong) UILabel *name;

@property (nonatomic, strong) UILabel *gf;

@end


@implementation DetailHeader




- (instancetype)initWithHero:(DetailHero *)hero
{
    self = [super init];
    if (self) {
        _hero = hero;
        [self layout];
    }
    return self;
}


- (void)layout
{
    _header = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/meta/%@",DEBUG_URL,_hero.img]];
    [_header sd_setImageWithURL:url];
    [self addSubview:_header];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(_header)+10, 10, 100, 20)];
    _name.text = _hero.name;
    _name.font= [UIFont systemFontOfSize:14];
    [self addSubview:_name];
    
    
    _gf=[[UILabel alloc] initWithFrame:CGRectMake(MaxX(_header)+10, 50, 200, 20)];
    _gf.text=[NSString stringWithFormat:@"生命%ld 物理%ld 法术%ld 团队%ld 操作%ld",(long)_hero.hp_rec,_hero.psy_rec,_hero.mp_rec,_hero.grp_rec,_hero.ope_rec];
    _gf.font=[UIFont systemFontOfSize:12];
    _gf.textColor=RGBCOLOR(153, 153, 153);
    [self addSubview:_gf];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
