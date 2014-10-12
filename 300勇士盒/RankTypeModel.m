//
//  RankTypeModel.m
//  300勇士盒
//
//  Created by ChenHao on 10/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "RankTypeModel.h"

@implementation RankTypeModel


-(NSInteger)getRankType
{
    NSArray  * array= [_Url componentsSeparatedByString:@"="];
    return [array[1] integerValue];
}
@end
