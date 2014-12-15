//
//  PicDAO.h
//  SportMan
//
//  Created by jasonWu on 14/11/23.
//  Copyright (c) 2014年 xxTeam. All rights reserved.
//

#import "CoreDataDAO.h"

@class PicObject;
@interface PicDAO : CoreDataDAO

-(BOOL)create:(PicObject*)model;

-(NSMutableArray*)findPlanBySportID:(NSString *)sportID;

-(BOOL)isExistImage:(NSString*)sportID;

-(NSArray *)getDirtyPic;

@end
