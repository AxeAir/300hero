//
//  PicDAO.h
//  SportMan
//
//  Created by jasonWu on 14/11/23.
//  Copyright (c) 2014年 xxTeam. All rights reserved.
//

#import "CoreDataDAO.h"
#import "CacheModel.h"

@interface CacheDAO : CoreDataDAO

- (BOOL)create:(CacheModel*)cache;


- (NSDictionary *)getjsonByRemote:(NSString*)url;
@end
