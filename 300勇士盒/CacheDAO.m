//
//  PicDAO.m
//  SportMan
//
//  Created by jasonWu on 14/11/23.
//  Copyright (c) 2014年 xxTeam. All rights reserved.
//

#import "PicDAO.h"
#import "PicObject.h"
#import "Pic.h"

@implementation PicDAO

- (BOOL)create:(PicObject *)model {
    
    NSManagedObjectContext *ctx=[self managedObjectContext];
    
    Pic *list=[NSEntityDescription insertNewObjectForEntityForName:@"Pic" inManagedObjectContext:ctx];
    
    list.gps = model.gps;
    list.sportID = model.sportID;
    list.picname = model.picname;
    list.timestamp = [NSNumber numberWithLong:[[NSDate  date] timeIntervalSince1970]];
    list.dirty= [NSNumber numberWithBool:YES];
    list.del= [NSNumber numberWithBool:NO];
    list.picID=[NSNumber numberWithLong:[[NSDate date] timeIntervalSince1970]];
    
    NSError *error = nil;
    BOOL isSave =   [self.managedObjectContext save:&error];
    if (!isSave) {
        NSLog(@"error:%@,%@",error,[error userInfo]);
        return NO;
    }
    else{
        NSLog(@"保存成功");
        
    }
    return YES;
    
}

- (NSMutableArray *)findPlanBySportID:(NSString *)sportID {
    
    NSManagedObjectContext *cxt=[self managedObjectContext];
    
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Pic" inManagedObjectContext:cxt];
    
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    //NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:"" ascending:<#(BOOL)#>]
    NSPredicate *TypePredicate = [NSPredicate predicateWithFormat:@"sportID =%@",sportID];
    [request setPredicate:TypePredicate];
    NSError *error=nil;
    NSArray *listData=[cxt executeFetchRequest:request error:&error];
    NSMutableArray *resListData=[[NSMutableArray alloc] init];
    
    for(Pic *model in listData)
    {
        PicObject *list=[[PicObject alloc] init];
        
        list.gps = model.gps;
        list.sportID = model.sportID;
        list.picname = model.picname;
        list.timestamp = model.timestamp;
        list.dirty=model.dirty;
        list.del=model.del;
        list.picID=model.picID;

        [resListData addObject:list];
    }
    return resListData;

    
}

-(BOOL)isExistImage:(NSString *)sportID
{
    NSManagedObjectContext *cxt=[self managedObjectContext];
    
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Pic" inManagedObjectContext:cxt];
    
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *TypePredicate = [NSPredicate predicateWithFormat:@"sportID =%@",sportID];
    [request setPredicate:TypePredicate];
    NSError *error=nil;
    NSArray *listData=[cxt executeFetchRequest:request error:&error];
    if([listData count]>0)
    {
        return YES;
    }
    return NO;
    
   
}


-(NSArray*)getDirtyPic
{
    NSManagedObjectContext *cxt=[self managedObjectContext];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Pic" inManagedObjectContext:cxt];
    
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *TypePredicate = [NSPredicate predicateWithFormat:@"dirty =1"];
    [request setPredicate:TypePredicate];
    NSError *error=nil;
    NSArray *listData=[cxt executeFetchRequest:request error:&error];
    NSMutableArray *resListData=[[NSMutableArray alloc] init];
    
    for(Pic *model in listData)
    {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
        
        [dic setValue:model.gps forKey:@"gps"];
        [dic setValue:model.sportID forKey:@"sportID"];
        [dic setValue:model.picname forKey:@"pictureName"];
        [dic setValue:model.timestamp forKey:@"timestamp"];
        [dic setValue:model.dirty forKey:@"dirty"];
        [dic setValue:model.del forKey:@"dele"];
        [dic setValue:model.picID forKey:@"pictureID"];
        
        
        [resListData addObject:dic];
    }
    return resListData;
}
@end
