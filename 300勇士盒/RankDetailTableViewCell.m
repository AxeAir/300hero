//
//  RankDetailTableViewCell.m
//  300勇士盒
//
//  Created by ChenHao on 10/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "RankDetailTableViewCell.h"
#import "UConstants.h"
#define CELLBG                 [UIColor colorWithRed:22/255.0f green:29/255.0f blue:38/255.0f alpha:1]
#define CELLNAMECOLOR                 [UIColor colorWithRed:149/255.0f green:149/255.0f blue:42/255.0f alpha:1]
#define CELLVALUECOLOR                 [UIColor colorWithRed:70/255.0f green:135/255.0f blue:66/255.0f alpha:1]
#define CELLSELECTEDCOLOR                 [UIColor colorWithRed:13/255.0f green:17/255.0f blue:23/255.0f alpha:1]
@implementation RankDetailTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)configCell:(RankDetailModel *)model {
    if(model.Index==1) {
        UIImageView *one=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"one"]];
        [one setFrame:CGRectMake(10, 5, 25, 30)];
        [self addSubview:one];
    }
    else if(model.Index==2) {
        UIImageView *one=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"two"]];
        [one setFrame:CGRectMake(10, 5, 25, 30)];
        [self addSubview:one];
    }
    else if(model.Index==3) {
        UIImageView *one=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"three"]];
        [one setFrame:CGRectMake(10, 5, 25, 30)];
        [self addSubview:one];
    }
    else {
        UILabel *NOlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        NOlabel.text=[NSString stringWithFormat:@"%ld",(long)model.Index];
        NOlabel.textAlignment=NSTextAlignmentCenter;
        NOlabel.textColor=CELLVALUECOLOR;
        [self addSubview:NOlabel];
    }
    UILabel *labelName=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 110, 30)];
    labelName.text=model.Name;
    _rolename=model.Name;
    [labelName setTextColor:CELLNAMECOLOR];
    [labelName setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:labelName];
    
    UILabel *value=[[UILabel alloc] initWithFrame:CGRectMake(180, 10, 80, 30)];
    value.text=[NSString stringWithFormat:@"%ld",(long)model.Value];
    [value setTextColor:CELLVALUECOLOR];
    [self addSubview:value];
    
    UILabel *change=[[UILabel alloc] initWithFrame:CGRectMake(Main_Screen_Width - 90, 10, 70, 30)];
    change.textAlignment=NSTextAlignmentCenter;
    if(model.RankChange>0)
    {
        change.text=[NSString stringWithFormat:@"↑%ld",(long)model.RankChange];
        change.textColor=[UIColor greenColor];
    }
    if(model.RankChange<0)
    {
        change.text=[NSString stringWithFormat:@"↓%ld",(long)model.RankChange];
        change.textColor=[UIColor redColor];
    }
    if(model.RankChange==0)
    {
        change.text=[NSString stringWithFormat:@"-%ld",(long)model.RankChange];
        change.textColor=[UIColor yellowColor];
    }
    
    UIView *bgview=[[UIView alloc] initWithFrame:self.bounds];
    bgview.backgroundColor=CELLSELECTEDCOLOR;
    [self setSelectedBackgroundView:bgview];
    [self setBackgroundColor:CELLBG];
    [self addSubview:change];
}



-(void)configLXCell:(RankDetailModel *)model type:(NSString *)type {
    if(model.Index==1)
    {
        UIImageView *one=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"one"]];
        [one setFrame:CGRectMake(10, 5, 25, 30)];
        [self addSubview:one];
    }
    else if(model.Index==2)
    {
        UIImageView *one=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"two"]];
        [one setFrame:CGRectMake(10, 5, 25, 30)];
        [self addSubview:one];
    }
    else if(model.Index==3) {
        UIImageView *one=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"three"]];
        [one setFrame:CGRectMake(10, 5, 25, 30)];
        [self addSubview:one];
    }
    else{
        UILabel *NOlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        NOlabel.text=[NSString stringWithFormat:@"%ld",(long)model.Index];
        NOlabel.textAlignment=NSTextAlignmentCenter;
        NOlabel.textColor=CELLVALUECOLOR;
        [self addSubview:NOlabel];
    }
    UILabel *labelName=[[UILabel alloc] initWithFrame:CGRectMake(100, 10, 110, 30)];
    labelName.text=model.Name;
    _rolename=model.Name;
    [labelName setTextColor:CELLNAMECOLOR];
    [labelName setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:labelName];
    
    
    UILabel *value=[[UILabel alloc] initWithFrame:CGRectMake(230, 10, 60, 30)];
    if([type isEqualToString:@"人生局"]) {
        value=[[UILabel alloc] initWithFrame:CGRectMake(200, 10, 100, 30)];
        value.text=[NSString stringWithFormat:@"%ld分%ld秒",(long)model.Value/60,(long)model%60];
    }
    else
        value.text=[NSString stringWithFormat:@"%ld",(long)model.Value];
    [value setTextColor:CELLVALUECOLOR];
    [self addSubview:value];
    
    
    UIView *bgview=[[UIView alloc] initWithFrame:self.bounds];
    bgview.backgroundColor=CELLSELECTEDCOLOR;
    [self setSelectedBackgroundView:bgview];
    [self setBackgroundColor:CELLBG];
}


- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
