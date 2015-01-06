//
//  RecentModel.m
//  300勇士盒
//
//  Created by ChenHao on 10/15/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "RecentModel.h"

@implementation RecentModel

-(id)initWithObject:(NSDictionary *)dic
{
    self=[self init];
    if (self) {
        
        _assist=[[dic objectForKey:@"assistCount"] integerValue];
        _combat=[[dic objectForKey:@"combat"] integerValue];
        _creeps=[[dic objectForKey:@"killUnitCount"] integerValue];
        _dead=[[dic objectForKey:@"deathCount"] integerValue];
        _destory=[[dic objectForKey:@"towerDestroy"] integerValue];
        _kills=[[dic objectForKey:@"killCount"] integerValue];
        _lastMatchID=[[dic objectForKey:@"lastMatchID"] integerValue];
        _money=[[dic objectForKey:@"totalMoney"] integerValue];
        _name=[dic objectForKey:@"name"];
        _seriesLose=[[dic objectForKey:@"seriesLose"] integerValue];
        _seriesWin=[[dic objectForKey:@"seriesWin"] integerValue];
        _searchCount=[[dic objectForKey:@"searchCount"] integerValue];
        _statisticCount=[[dic objectForKey:@"statisticCount"] integerValue];
        _loseCount=[[dic objectForKey:@"loseCount"] integerValue];
        _winCount=[[dic objectForKey:@"winCount"] integerValue];
        
    }
    return self;
}

-(NSInteger)getSum
{
    if(_statisticCount==0)
    {
        return 1;
    }
    else
    {
        return _statisticCount;
    }
}

@end
