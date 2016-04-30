//
//  HeroLayout.m
//  300勇士盒
//
//  Created by ChenHao on 16/4/29.
//  Copyright © 2016年 xxTeam. All rights reserved.
//

#import "HeroLayout.h"
#import "UConstants.h"

@implementation HeroLayout

- (void)prepareLayout {
    self.sectionInset = UIEdgeInsetsMake(30, 15, 5, 15);
    self.minimumLineSpacing = 15;
    self.minimumInteritemSpacing = 15;
    CGFloat width = (Main_Screen_Width - 75)/4;
    self.itemSize = CGSizeMake(width, width + 30);
}

@end
