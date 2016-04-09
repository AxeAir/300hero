//
//  EquipCell.m
//  300勇士盒
//
//  Created by ChenHao on 16/4/9.
//  Copyright © 2016年 xxTeam. All rights reserved.
//

#import "EquipCell.h"
#import <UIImageView+WebCache.h>

@interface EquipCell()
@property (weak, nonatomic) IBOutlet UIImageView *equipImageView;
@property (weak, nonatomic) IBOutlet UILabel *equipLabel;

@end

@implementation EquipCell

- (void)filleWithObject:(Equip *)equip {
    [self.equipImageView sd_setImageWithURL:[NSURL URLWithString:equip.img]];
    [self.equipLabel setText:equip.name];
}

@end
