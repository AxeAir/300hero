//
//  HeroCell.m
//  300勇士盒
//
//  Created by ChenHao on 16/4/29.
//  Copyright © 2016年 xxTeam. All rights reserved.
//

#import "HeroCell.h"
#import <UIImageView+WebCache.h>

@interface HeroCell()
@property (weak, nonatomic) IBOutlet UIImageView *heroImageView;
@property (weak, nonatomic) IBOutlet UILabel *heroLabel;

@end

@implementation HeroCell

- (void)filleWithObject:(Hero *)hero {
    [self.heroImageView sd_setImageWithURL:[NSURL URLWithString:hero.img]];
    [self.heroLabel setText:hero.name];
}

@end
