//
//  ToolFlowLayout.m
//  300勇士盒
//
//  Created by ChenHao on 16/4/9.
//  Copyright © 2016年 xxTeam. All rights reserved.
//

#import "ToolFlowLayout.h"
#import "UConstants.h"

@implementation ToolFlowLayout

- (void)prepareLayout {
//    self.sectionInset = UIEdgeInsetsMake(30, 15, 5, 15);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.itemSize = CGSizeMake(Main_Screen_Width/3, Main_Screen_Width/3);
}

@end
