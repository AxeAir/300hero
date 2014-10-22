//
//  MatchTableViewCell.m
//  300勇士盒
//
//  Created by ChenHao on 10/13/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "MatchTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation MatchTableViewCell


-(void)config:(MatchModel *)model
{
    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    _MatchID=model.MatchID;
    UIImageView *header=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://300report.jumpw.com/static/images/%@",model.HeroIconFile]];
    [header sd_setImageWithURL:url];
    [self setBackgroundColor:[UIColor colorWithRed:22/255.0 green:27/255.0 blue:33/255.0 alpha:1]];
    [self addSubview:header];
    
    if(_type==nil)
    {
        _type=[[UILabel alloc] initWithFrame:CGRectMake(60, 15, 60, 20)];
        [_type setTextColor:[UIColor colorWithRed:107/255.0 green:145/255.0 blue:143/255.0 alpha:1]];
    }
    if(model.MatchType==1)
    {
        _type.text=@"竞技场";
    }
    else
    {
        _type.text=@"战场";
    }
    
    [self addSubview:_type];
    
    if(_result==nil)
    {
        _result=[[UILabel alloc] initWithFrame:CGRectMake(130, 15, 40, 20)];
    }
    if(model.Result==1)
    {
        _result.text=@"胜利";
        _result.textColor=[UIColor colorWithRed:92/255.0 green:192/255.0 blue:11/255.0 alpha:1];
    }else
    {
        _result.text=@"失败";
        _result.textColor=[UIColor colorWithRed:220/255.0 green:25/255.0 blue:1/255.0 alpha:1];
        
    }
    
    
    _data=[[UILabel alloc] initWithFrame:CGRectMake(200, 15, 60, 20)];
    _data.text=[model getData];
    _data.textColor=[UIColor colorWithRed:107/255.0 green:145/255.0 blue:143/255.0 alpha:1];
    [self addSubview:_data];
    
    [self addSubview:_result];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
