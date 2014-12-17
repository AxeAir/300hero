//
//  NewsTableViewCell.m
//  300勇士盒
//
//  Created by ChenHao on 12/8/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "UConstants.h"
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
        
    }
    return self;
}

-(void)layout:(NewsModel *)news
{
    _image=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 60)];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/meta/%@",DEBUG_URL,news.img]];
    [_image sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
    [self.contentView addSubview:_image];
    
    _headerone=[[UILabel alloc] initWithFrame:CGRectMake(100, 12, 200, 20)];
    [_headerone setText:news.title];
    [_headerone setFont:[UIFont boldSystemFontOfSize:16]];
    [self.contentView addSubview:_headerone];
    
    _headertwo=[[UILabel alloc] initWithFrame:CGRectMake(100, 35, 200, 20)];
    [_headertwo setText:news.subTitle];
    [_headertwo setFont:[UIFont boldSystemFontOfSize:12]];
    [_headertwo setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:_headertwo];
    
    _readcount=[[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-110, 60, 100, 20)];
    [_readcount setTextAlignment:NSTextAlignmentRight];
    [_readcount setTextColor:[UIColor grayColor]];
    [_readcount setText:[NSString stringWithFormat:@"阅读量%ld",news.pageViews]];
    [_readcount setFont:[UIFont boldSystemFontOfSize:12]];
    //[self.contentView addSubview:_readcount];
}



- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
