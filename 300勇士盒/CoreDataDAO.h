//
//  CoreDataDAO.h
//  SportMan
//
//  Created by ChenHao on 11/9/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataDAO : NSObject


@property (readonly,strong,nonatomic) NSManagedObjectContext *managedObjectContext;

@property (readonly,strong,nonatomic) NSManagedObjectModel *managedObjectModel;

@property (readonly,strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
