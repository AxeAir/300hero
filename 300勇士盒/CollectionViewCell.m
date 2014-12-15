//
//  CollectionViewCell.m
//  collectionTest
//
//  Created by ChenHao on 12/10/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "CollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "UConstants.h"
@implementation CollectionViewCell


- (instancetype)init
{
    self=[super init];
    if (self) {
        [self setRestorationIdentifier:@"CollectionViewCell"];
    }
    return self;
}

- (void)layout:(HeroListModel*)hero
{
    UIImageView *header=[[UIImageView alloc] init];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/meta/%@",DEBUG_URL,hero.img]];
    [header sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
    
    [header setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
    [self.contentView addSubview:header];
    
    UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.width, self.frame.size.width, 20)];
    [name setTextAlignment:NSTextAlignmentCenter];
    [name setFont:[UIFont systemFontOfSize:12]];
    name.text=hero.name;
    [self.contentView addSubview:name];
    NSLog(@"%@",hero.atk_type);
    
}

@end
