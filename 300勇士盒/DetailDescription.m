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
#import "CacheEntence.h"
#import "SingleEquipTableViewCell.h"
#import "EquipTableViewController.h"
#import "DetailHeroViewController.h"

@interface DetailDescription()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) DetailHero  *hero;

@property (nonatomic, assign) NSInteger   heroID;

@property (nonatomic, assign) NSInteger   currentskill;



@property (nonatomic, strong) UILabel     *skillName;
@property (nonatomic, strong) UILabel     *skillDesc;
@property (nonatomic, strong) UILabel     *skillcost;
@property (nonatomic, strong) UILabel     *skillcooling;

@property (nonatomic, strong) UILabel     *heroDes;



@property (nonatomic, strong) UITableView *equipTable;

@property (nonatomic, strong) NSArray     *equipData;
@end

@implementation DetailDescription


- (instancetype)initWithHero:(DetailHero *)hero type:(NSInteger)type heroID:(NSInteger)heroID
{
    self = [super init];
    if (self) {
        _hero = hero;
        _heroID= heroID;
        if (type==0) {
            [self layoutSkill];
            _currentskill = 0;
        }
        if (type==1) {
            [self heroDesc];
        }
        if (type==2) {
            [self layoutEquip];
        }
        
        
    }
    return self;
}



#pragma private method desc
- (void)heroDesc
{
    _heroDes=[self getLabel:CGPointMake(10, MaxY(_skillcooling)+5) text:_hero.desc offset:20];
    [self addSubview:_heroDes];
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
    
    _skillDesc=[self getLabel:CGPointMake(50, MaxY(_skillName)+5) text:sk.desc offset:60];
    [self addSubview:_skillDesc];
    
    UILabel *cd=[[UILabel alloc] initWithFrame:CGRectMake(10, MaxY(_skillDesc)+4, 40, 20)];
    cd.text=@"冷却";
    [cd setFont:[UIFont systemFontOfSize:14]];
    [cd setTextColor:RGBCOLOR(153, 153, 153)];
    [self addSubview:cd];
    
    _skillcooling=[self getLabel:CGPointMake(50, MaxY(_skillDesc)+5) text:sk.cooling offset:60];
    [self addSubview:_skillcooling];
    
    UILabel *xh=[[UILabel alloc] initWithFrame:CGRectMake(10, MaxY(_skillcooling)+4, 40, 20)];
    xh.text=@"消耗";
    [xh setFont:[UIFont systemFontOfSize:14]];
    [xh setTextColor:RGBCOLOR(153, 153, 153)];
    [self addSubview:xh];
    
    _skillcost=[self getLabel:CGPointMake(50, MaxY(_skillcooling)+5) text:sk.cost offset:60];
    [self addSubview:_skillcost];
    
    NSLog(@"%f",MaxY(_skillcost));
    
    [self setContentSize:CGSizeMake(Main_Screen_Width, MaxY(_skillcost)+200)];
    
    
    
}

- (UILabel *)getLabel:(CGPoint)point text:(NSString *)text offset:(NSInteger)offset
{
    //初始化label
    
    // 初始化label
    UILabel *label = [UILabel new];
    
    // label获取字符串
    label.text = text;
    
    
    // label获取字体
    label.font = [UIFont systemFontOfSize:14];
    
    // 根据获取到的字符串以及字体计算label需要的size
    CGSize size = [self boundingRectWithSize:CGSizeMake(Main_Screen_Width-offset, 0) font:label.font text:text];
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



- (void)layoutEquip
{
    NSDictionary *paramters=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)_heroID],@"heroID", nil];
    [CacheEntence RequestRemoteURL:[NSString stringWithFormat:@"%@getHeroEquip/",DEBUG_URL] paramters:paramters Cache:NO success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        NSString *status = [responseObject objectForKey:@"Status"];
        if ([status isEqualToString:@"OK"]) {
            NSDictionary *equips=[responseObject objectForKey:@"Result"];
            if ([equips count]!=0) {
                
                NSMutableArray *temp = [[NSMutableArray alloc] init];
                for ( NSDictionary *resultEach in equips) {
                    NSLog(@"%@",resultEach);
                    [temp addObject:resultEach];
                }
                _equipData=temp;
                NSLog(@"%@",_equipData);
                [_equipTable reloadData];
                
            }
            else
            {
                
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    _equipTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    _equipTable.delegate=self;
    _equipTable.dataSource=self;
    _equipTable.tableFooterView = [[UIView alloc] init];
    
    [self addSubview:_equipTable];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_equipData count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer= @"equipID";
    SingleEquipTableViewCell *cell= [_equipTable dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell=[[SingleEquipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    else
    {
        for (UIView *v in cell.contentView.subviews) {
            [v removeFromSuperview];
        }
    }
    
    NSDictionary *dic =[_equipData objectAtIndex:indexPath.row];
    NSLog(@"%@",dic);
    [cell config:dic];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic =[_equipData objectAtIndex:indexPath.row];
    EquipTableViewController *eqVC=[[EquipTableViewController alloc] iniWithDictionary:dic];
    DetailHeroViewController *vc=(DetailHeroViewController*)[self viewController];
    [vc.navigationController pushViewController:eqVC animated:YES];
    
    NSLog(@"%@",[[self viewController] class]);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


//得到此view 所在的viewController
- (UIViewController*)viewController {
    for (UIView* next = [self superview];next; next =next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}




@end
