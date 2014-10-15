//
//  MatchModel.m
//  300勇士盒
//
//  Created by ChenHao on 10/13/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "MatchModel.h"

@implementation MatchModel


-(id)initWithDictionary:(NSDictionary *)dic
{
    self=[super init];
    if(self){
        _HeroLevel=[[dic objectForKey:@"HeroLevel"] integerValue];
        _MatchDate=[dic objectForKey:@"MatchDate"];
        _MatchID=[[dic objectForKey:@"MatchID"] integerValue];
        _MatchType=[[dic objectForKey:@"MatchType"] integerValue];
        _Result=[[dic objectForKey:@"Result"] integerValue];
    
        NSDictionary *hero=[dic objectForKey:@"Hero"];
        _HeroID=[[hero objectForKey:@"ID"] integerValue];
        _HeroIconFile=[hero objectForKey:@"IconFile"];
        _HeroName=[hero objectForKey:@"Name"];
    }
    return self;
}



@end
