//
//  RecentModel.h
//  300勇士盒
//
//  Created by ChenHao on 10/15/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentModel : NSObject
@property (nonatomic,assign) NSUInteger assist;
@property (nonatomic,assign) NSUInteger combat;
@property (nonatomic,assign) NSUInteger creeps;
@property (nonatomic,assign) NSUInteger dead;
@property (nonatomic,assign) NSUInteger destory;
//id = 1;
@property (nonatomic,assign) NSUInteger kills;
@property (nonatomic,assign) NSUInteger lastMatchID;
@property (nonatomic,assign) NSUInteger money;
@property (nonatomic,strong) NSString   *name;
@property (nonatomic,assign) NSUInteger searchCount;
@property (nonatomic,assign) NSUInteger seriesLose;
@property (nonatomic,assign) NSUInteger seriesWin;
@property (nonatomic,assign) NSUInteger statisticCount;
@property (nonatomic,assign) NSUInteger loseCount;
@property (nonatomic,assign) NSUInteger winCount;

-(id)initWithObject:(NSDictionary*)dic;
-(NSInteger)getSum;
@end
