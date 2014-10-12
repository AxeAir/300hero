//
//  RankDetailTableViewCell.m
//  300勇士盒
//
//  Created by ChenHao on 10/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "RankDetailTableViewCell.h"

@implementation RankDetailTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.backgroundColor=[UIColor redColor];
    }
    return self;
}

-(void)configCell:(RankDetailModel *)model
{
    UILabel *NOlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    NOlabel.text=[NSString stringWithFormat:@"%d",model.Index];
    NOlabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:NOlabel];
    
    UILabel *labelName=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 110, 30)];
    labelName.text=model.Name;
    [self addSubview:labelName];
    
    
    UILabel *value=[[UILabel alloc] initWithFrame:CGRectMake(180, 10, 60, 30)];
    value.text=[NSString stringWithFormat:@"%d",model.Value];
    [self addSubview:value];
    
    UILabel *change=[[UILabel alloc] initWithFrame:CGRectMake(260, 10, 40, 30)];
    change.textAlignment=NSTextAlignmentRight;
    if(model.RankChange>0)
    {
        change.text=[NSString stringWithFormat:@"↑%d",model.RankChange];
        change.textColor=[UIColor greenColor];
    }
    if(model.RankChange<0)
    {
        change.text=[NSString stringWithFormat:@"↓%d",model.RankChange];
        change.textColor=[UIColor redColor];
    }
    if(model.RankChange==0)
    {
        change.text=[NSString stringWithFormat:@"-%d",model.RankChange];
        change.textColor=[UIColor yellowColor];
    }
    
    [self addSubview:change];
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
