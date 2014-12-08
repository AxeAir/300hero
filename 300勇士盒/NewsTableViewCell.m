//
//  NewsTableViewCell.m
//  300勇士盒
//
//  Created by ChenHao on 12/8/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "NewsTableViewCell.h"
@interface NewsTableViewCell()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *headerone;
@property (nonatomic, strong) UILabel *headertwo;

@property (nonatomic, strong) UILabel *readcount;
@end


@implementation NewsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layout];
    }
    return self;
}

-(void)layout
{
    _image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img1.jpg"]];
    [_image setFrame:CGRectMake(10, 10, 80, 60)];
    [self addSubview:_image];
    
    _headerone=[[UILabel alloc] initWithFrame:CGRectMake(100, 12, 200, 20)];
    [_headerone setText:@"梁逸峰自杀身亡"];
    [_headerone setFont:[UIFont boldSystemFontOfSize:16]];
    [self addSubview:_headerone];
    
    _headertwo=[[UILabel alloc] initWithFrame:CGRectMake(100, 35, 200, 20)];
    [_headertwo setText:@"梁逸峰连输1000把自杀身亡"];
    [_headertwo setFont:[UIFont boldSystemFontOfSize:12]];
    [_headertwo setTextColor:[UIColor grayColor]];
    [self addSubview:_headertwo];
    
    _readcount=[[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-110, 60, 100, 20)];
    [_readcount setTextAlignment:NSTextAlignmentRight];
    [_readcount setTextColor:[UIColor grayColor]];
    [_readcount setText:@"阅读量13亿"];
    [_readcount setFont:[UIFont boldSystemFontOfSize:12]];
    [self addSubview:_readcount];
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
