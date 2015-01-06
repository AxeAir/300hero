//
//  SIngleEquipTableViewCell.m
//  300勇士盒
//
//  Created by ChenHao on 1/4/15.
//  Copyright (c) 2015 xxTeam. All rights reserved.
//

#import "SIngleEquipTableViewCell.h"
#import <JSONKit.h>
#import "UConstants.h"

@interface SingleEquipTableViewCell()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *common;

@end

@implementation SingleEquipTableViewCell


- (void)config:(NSDictionary *)dic
{
    NSDictionary *json = [dic objectForKey:@"equipJson"];
    
    NSString *author = [dic objectForKey:@"nick"];
    
    NSDictionary *houqi = [json objectForKey:@"hou"];    
    NSArray *equip= [houqi objectForKey:@"equip"];
    
    _common = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 180, 20)];
    [_common setFont:[UIFont systemFontOfSize:14]];
    [_common setTextColor:[UIColor blackColor]];
    [_common setText:[NSString stringWithFormat:@"%@",[houqi objectForKey:@"common"]]];
    
    [self.contentView addSubview:_common];
    
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(Main_Screen_Width-100, 5, 80, 20)];
    [_name setFont:[UIFont systemFontOfSize:12]];
    [_name setTextAlignment:NSTextAlignmentRight];
    [_name setTextColor:[UIColor grayColor]];
    [_name setText:[NSString stringWithFormat:@"作者:%@",author]];
    
    [self.contentView addSubview:_name];
    
    int width = (Main_Screen_Width-40 -25)/6;
    int i=0;
    for (NSString *ID in equip) {
        UIImageView *eq = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",ID]]];
        [eq setFrame:CGRectMake(15+5*(i+1)+width*i, 30,width , width)];
        [self.contentView addSubview:eq];
        i++;
    }
    
}

- (void)configDetail:(NSDictionary *)dic
{
    NSArray *equip= [dic objectForKey:@"equip"];
    
    _common = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, Main_Screen_Width-60, 20)];
    _common = [self getLabel:CGPointMake(60, 6) text:[dic objectForKey:@"common"] offset:60];
    [_common setFont:[UIFont systemFontOfSize:14]];
    [_common setTextColor:[UIColor blackColor]];
    //[_common setText:[NSString stringWithFormat:@"%@",]];
    
    [self.contentView addSubview:_common];
    UIImageView *eq;
    int width = (Main_Screen_Width-40 -25)/6;
    int i=0;
    for (NSString *ID in equip) {
        eq = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",ID]]];
        [eq setFrame:CGRectMake(15+5*(i+1)+width*i, MaxY(_common)+10,width , width)];
        [self.contentView addSubview:eq];
        i++;
    }
    
    CGRect frame= self.frame;
    frame.size.height=MaxY(eq)+10;
    self.frame=frame;
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
    [label setTextColor:[UIColor blackColor]];
    
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





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
