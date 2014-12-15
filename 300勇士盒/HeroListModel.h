//
//  HeroList.h
//  300勇士盒
//
//  Created by ChenHao on 12/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroListModel : NSObject

@property (nonatomic, assign) NSInteger heroid;
@property (nonatomic, strong) NSString  *img;
@property (nonatomic, strong) NSString  *name;
@property (nonatomic, strong) NSString  *type;
@property (nonatomic, strong) NSString  *atk_type;

+ (NSArray*)getHerolist:(NSDictionary *)dic;

@end
