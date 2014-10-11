//
//  RankTypeModel.h
//  300勇士盒
//
//  Created by ChenHao on 10/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankTypeModel : NSObject

@property (nonatomic,assign) NSInteger Index;           // 名次
@property (nonatomic,strong) NSString  *Url;            // 链接地址
@property (nonatomic,strong) NSString  *Name;           // 玩家名
@property (nonatomic,strong) NSString  *Value;          // 值
@property (nonatomic,assign) NSInteger RankChange;       // 名次改变

@end
