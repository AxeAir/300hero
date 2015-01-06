//
//  NewsModel.h
//  300勇士盒
//
//  Created by ChenHao on 12/10/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject


@property (nonatomic, strong) NSString  *author;
@property (nonatomic, strong) NSString  *content;
@property (nonatomic, strong) NSString  *editDate;
@property (nonatomic, assign) NSInteger newsid;
@property (nonatomic, strong) NSString  *img;
@property (nonatomic, assign) NSInteger like;
@property (nonatomic, assign) NSInteger pageViews;
@property (nonatomic, strong) NSString  *subTitle;
@property (nonatomic, strong) NSString  *title;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString  *url;



+ (NSArray*)getlatestNews:(NSDictionary *)dic;

@end
