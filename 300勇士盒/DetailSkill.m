//
//  DetailSkill.m
//  300勇士盒
//
//  Created by ChenHao on 12/15/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "DetailSkill.h"

@implementation DetailSkill

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _cooling = [dic objectForKey:@"cooling"];
        _desc = [dic objectForKey:@"desc"];
        _hero = [dic objectForKey:@"hero"];
        _cost = [dic objectForKey:@"cost"];
        _img = [dic objectForKey:@"img"];
        _name = [dic objectForKey:@"name"];
        _shortcut = [dic objectForKey:@"shortcut"];
        
    }
    return self;
}

@end
