//
//  DetailSkill.h
//  300勇士盒
//
//  Created by ChenHao on 12/15/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailSkill : NSObject

@property (nonatomic, strong) NSString *cooling;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *hero;
@property (nonatomic, strong) NSString *cost;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *shortcut;


- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
