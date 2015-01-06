//
//  Cache.h
//  300勇士盒
//
//  Created by ChenHao on 12/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Cache : NSManagedObject

@property (nonatomic, retain) NSString * remoteURL;
@property (nonatomic, retain) NSNumber * expiryDate;
@property (nonatomic, retain) NSData * returnJson;

@end
