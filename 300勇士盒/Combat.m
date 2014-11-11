//
//  Combat.m
//  300勇士盒
//
//  Created by ChenHao on 10/28/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "Combat.h"

@implementation Combat

+(NSInteger)getCombat:(Role *)role
{
    
    
    NSInteger winScore=2*pow(role.WinCount, 0.9);
    if(winScore>=3500)
    {
        winScore=3500;
    }
    
    double winRatio=(double)role.WinCount/role.MatchCount;
    NSInteger rateScore;
    if(winRatio<0.5)
    {
        rateScore=750+100*pow((winRatio*100-50), 0.7);
    }
    else
    {
        rateScore=750-100*pow((winRatio*100-50), 0.7);
        if(rateScore<=0)
        {
            rateScore=0;
        }
    }
    
    //750+100*(winRatio-50)^0.7；如果胜率低于50%，胜率加成分公式：750 -(100*(50-$winRatio)^0.7)。胜率加成分下面用winRatioScore代替.
    
    
    return winScore+rateScore;
}

+(NSString*)getCombat:(NSInteger)win all:(NSInteger)all
{
    NSInteger winScore=2*pow((double)win, 0.9);
   
    NSLog(@"%d",winScore);
    
    
    double winRatio=(double)win/all;
    NSInteger rateScore;
    if(winRatio>0.5)
    {
        rateScore=750+100*pow((winRatio*100-50), 0.7);
    }
    else
    {
        rateScore=750-100*pow((winRatio*100-50), 0.7);
        if(rateScore<=0)
        {
            rateScore=0;
        }
    }
    
    //750+100*(winRatio-50)^0.7；如果胜率低于50%，胜率加成分公式：750 -(100*(50-$winRatio)^0.7)。胜率加成分下面用winRatioScore代替.
    
    NSLog(@"%d",rateScore);
    return [NSString stringWithFormat:@"%d",winScore+rateScore];
    
}


@end
