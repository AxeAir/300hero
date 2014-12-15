//
//  DetailDescription.m
//  300勇士盒
//
//  Created by ChenHao on 12/15/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "DetailDescription.h"
#import "DetailSkill.h"
#import "UConstants.h"
#import <UIImageView+WebCache.h>


@interface DetailDescription()
@property (nonatomic, strong) DetailHero *hero;



@property (nonatomic, assign) NSInteger currentskill;



@property (nonatomic, strong) UILabel *skillName;
@property (nonatomic, strong) UILabel *skillDesc;
@property (nonatomic, strong) UILabel *skillcost;
@property (nonatomic, strong) UILabel *skillcooling;
@end

@implementation DetailDescription


- (instancetype)initWithHero:(DetailHero *)hero type:(NSInteger)type
{
    self = [super init];
    if (self) {
        _hero = hero;
        if (type==0) {
            [self layoutSkill];
            _currentskill = 0;
        }
        if (type==1) {
            
        }
        
    }
    return self;
}










#pragma paivate method skills
- (void)layoutSkill
{
    NSInteger width=(Main_Screen_Width-60)/5;
    for (int i=0;i<[_hero.skills count];i++) {
        DetailSkill *s = _hero.skills[i];
        UIImageView *skill=[[UIImageView alloc] initWithFrame:CGRectMake(10+(width+10)*i, 10, width, width)];
        skill.tag=38888+i;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeSkill:)];
        [skill addGestureRecognizer:tap];
        [skill setUserInteractionEnabled:YES];
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/meta/%@",DEBUG_URL,s.img]];
        [[skill layer] setCornerRadius:9.0];
        [[skill layer] setMasksToBounds:YES];
        if (_currentskill!=i) {
            [skill setAlpha:0.6];
        }
        [skill sd_setImageWithURL:url];
        [self addSubview:skill];
    }
    
    [self setskillDesc];
    
}

- (void)changeSkill:(UITapGestureRecognizer*)recognizer
{
    _currentskill = recognizer.view.tag-38888;
    
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    [self layoutSkill];
    
}


- (void)setskillDesc
{
    DetailSkill *sk = [_hero.skills objectAtIndex:_currentskill];
    _skillName = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 200, 20)];
    _skillName.text=sk.name;
    [self addSubview:_skillName];
    
    UILabel *desc=[[UILabel alloc] initWithFrame:CGRectMake(10, MaxY(_skillName)+4, 40, 20)];
    desc.text=@"描述";
    [desc setFont:[UIFont systemFontOfSize:14]];
    [desc setTextColor:RGBCOLOR(153, 153, 153)];
    [self addSubview:desc];
    
    _skillDesc=[self getLabel:CGPointMake(50, MaxY(_skillName)+5) text:sk.desc];
    [self addSubview:_skillDesc];
    
    UILabel *cd=[[UILabel alloc] initWithFrame:CGRectMake(10, MaxY(_skillDesc)+4, 40, 20)];
    cd.text=@"冷却";
    [cd setFont:[UIFont systemFontOfSize:14]];
    [cd setTextColor:RGBCOLOR(153, 153, 153)];
    [self addSubview:cd];
    
    _skillcooling=[self getLabel:CGPointMake(50, MaxY(_skillDesc)+5) text:sk.cooling];
    [self addSubview:_skillcooling];
    
    UILabel *xh=[[UILabel alloc] initWithFrame:CGRectMake(10, MaxY(_skillcooling)+4, 40, 20)];
    xh.text=@"消耗";
    [xh setFont:[UIFont systemFontOfSize:14]];
    [xh setTextColor:RGBCOLOR(153, 153, 153)];
    [self addSubview:xh];
    
    _skillcost=[self getLabel:CGPointMake(50, MaxY(_skillcooling)+5) text:sk.cost];
    [self addSubview:_skillcost];
    
    
    
    
    
}

- (UILabel *)getLabel:(CGPoint)point text:(NSString *)text
{
    //初始化label
    
    // 初始化label
    UILabel *label = [UILabel new];
    
    // label获取字符串
    label.text = text;
    
    
    // label获取字体
    label.font = [UIFont systemFontOfSize:14];
    
    // 根据获取到的字符串以及字体计算label需要的size
    CGSize size = [self boundingRectWithSize:CGSizeMake(Main_Screen_Width-60, 0) font:label.font text:text];
    
    // 设置无限换行
    label.numberOfLines = 0;
    
    // 设置label的frame
    label.frame = CGRectMake(point.x, point.y, size.width, size.height);
    return label;
}

- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font text:(NSString *)text
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
