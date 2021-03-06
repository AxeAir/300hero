//
//  Hero.h
//  300勇士盒
//
//  Created by ChenHao on 16/4/29.
//  Copyright © 2016年 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVSubclassing.h>
#import <AVObject.h>

@interface Hero : AVObject <AVSubclassing>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *bigimg;
@property (strong, nonatomic) NSString *price1;
@property (strong, nonatomic) NSString *price2;
@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *introduce;
@property (strong, nonatomic) NSString *skills;
@property (strong, nonatomic) NSString *img;
@property (strong, nonatomic) NSString *rate;

@end
