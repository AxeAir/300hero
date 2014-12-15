//
//  CacheModel.h
//  300勇士盒
//
//  Created by ChenHao on 12/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheModel : NSObject

@property (nonatomic, strong) NSString * remoteURL;
@property (nonatomic, strong) NSNumber * expiryDate;
@property (nonatomic, strong) NSDictionary * returnJson;

@end
