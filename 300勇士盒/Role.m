//
//  Role.m
//  300勇士盒
//
//  Created by ChenHao on 10/15/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "Role.h"

@implementation Role

-(id)initWithObject:(NSDictionary *)dic
{
    self=[super init];
    if (self) {
        _JumpValue=[[dic objectForKey:@"JumpValue"] integerValue];
        _MatchCount=[[dic objectForKey:@"MatchCount"] integerValue];
        _RoleLevel=[[dic objectForKey:@"RoleLevel"] integerValue];
        _RoleName=[dic objectForKey:@"RoleName"];
        _UpdateTime=[dic objectForKey:@"UpdateTime"];
        _WinCount=[[dic objectForKey:@"WinCount"] integerValue];
        
    }
    return self;
}
@end
