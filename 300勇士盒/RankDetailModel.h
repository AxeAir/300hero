//
//  RankDetailModel.h
//  300勇士盒
//
//  Created by ChenHao on 10/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankDetailModel : NSObject

@property (nonatomic,assign) NSInteger Index;
@property (nonatomic,strong) NSString *Url;
@property (nonatomic,strong) NSString *Name;
@property (nonatomic,assign) NSInteger Value;
@property (nonatomic,assign) NSInteger RankChange;

@end
