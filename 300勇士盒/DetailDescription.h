//
//  DetailDescription.h
//  300勇士盒
//
//  Created by ChenHao on 12/15/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailHero.h"

@interface DetailDescription : UIScrollView

- (instancetype)initWithHero:(DetailHero *)hero type:(NSInteger)type;

@end
