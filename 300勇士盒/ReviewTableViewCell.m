//
//  ReviewTableViewCell.m
//  300勇士盒
//
//  Created by ChenHao on 1/4/15.
//  Copyright (c) 2015 xxTeam. All rights reserved.
//

#import "ReviewTableViewCell.h"
#import "UConstants.h"
@interface ReviewTableViewCell()

@property (nonatomic, strong) UIImageView *header;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *time;

@end

@implementation ReviewTableViewCell


- (void)config:(NSDictionary *)dic
{
    _header = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 30, 30)];
    [[_header layer] setCornerRadius:15.0];
    [[_header layer] setMasksToBounds:YES];
    
    [_header setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[dic objectForKey:@"avatarNum"]]]];
    [self.contentView addSubview:_header];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(_header)+10, 5, 200, 20)];
    _name.text = [dic objectForKey:@"nick"];
    [_name setFont:[UIFont boldSystemFontOfSize:14]];
    [self.contentView addSubview:_name];
    
    UILabel *label = [self getLabel:CGPointMake(MaxX(_header)+10, 25) text:[dic objectForKey:@"content"] offset:MaxX(_header)+20];
    [self.contentView addSubview:label];
    
    _time = [[UILabel alloc] initWithFrame:CGRectMake(Main_Screen_Width-135, 5, 135, 20)];
    [_time setTextColor:[UIColor grayColor]];
    _time.text=[dic objectForKey:@"commentDate"];
    [_time setFont:[UIFont systemFontOfSize:12]];
    [self.contentView addSubview:_time];
    
    
    CGRect frame= self.frame;
    frame.size.height=MaxY(label)+10;
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
