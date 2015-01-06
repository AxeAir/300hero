//
//  HeroList.m
//  300勇士盒
//
//  Created by ChenHao on 12/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "HeroListModel.h"

@implementation HeroListModel


+ (NSArray*)getHerolist:(NSDictionary *)dic
{
    NSMutableArray *temp=[[NSMutableArray alloc] init];
    for (NSDictionary *d in dic) {
        HeroListModel *hero=[[HeroListModel alloc] init];
        hero.heroid =[[d objectForKey:@"id"] integerValue];
        hero.img =[d objectForKey:@"img"];
        hero.name =[d objectForKey:@"name"];
        hero.type =[d objectForKey:@"type"];
        hero.atk_type =[d objectForKey:@"atk_type"];
        [temp addObject:hero];
    }
    return temp;
}
@end
