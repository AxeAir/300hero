//
//  NewsModel.m
//  300勇士盒
//
//  Created by ChenHao on 12/10/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+ (NSArray*)getlatestNews:(NSDictionary *)dic
{
    NSMutableArray *temp=[[NSMutableArray alloc] init];
    for (NSDictionary *d in dic) {
        NewsModel *news=[[NewsModel alloc] init];
        news.author =[d objectForKey:@"author"];
        news.content =[d objectForKey:@"author"];
        news.editDate =[d objectForKey:@"editDate"];
        news.newsid =[[d objectForKey:@"id"] integerValue];
        news.img =[d objectForKey:@"img"];
        news.like =[[d objectForKey:@"like"] integerValue];
        news.pageViews =[[d objectForKey:@"pageViews"] integerValue];
        news.subTitle =[d objectForKey:@"subTitle"];
        news.title =[d objectForKey:@"title"];
        news.type =[[d objectForKey:@"type"] integerValue];
        
        [temp addObject:news];
    }
    return temp;
}

@end
