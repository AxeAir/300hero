//
//  Role.h
//  300勇士盒
//
//  Created by ChenHao on 10/15/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Role : NSObject

@property (nonatomic,assign) NSUInteger JumpValue;
@property (nonatomic,assign) NSUInteger MatchCount;
@property (nonatomic,assign) NSUInteger RoleLevel;
@property (nonatomic,strong) NSString   *RoleName;
@property (nonatomic,strong) NSString   *UpdateTime;
@property (nonatomic,assign) NSUInteger WinCount;


-(id)initWithObject:(NSDictionary*)dic;


@end
