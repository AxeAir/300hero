//
//  Combat.h
//  300勇士盒
//
//  Created by ChenHao on 10/28/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Role.h"
@interface Combat : NSObject


+(NSInteger)getCombat:(Role*)role;
+(NSString*)getCombat:(NSInteger)win all:(NSInteger)all;
@end
