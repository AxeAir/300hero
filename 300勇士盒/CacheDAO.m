//
//  PicDAO.m
//  SportMan
//
//  Created by jasonWu on 14/11/23.
//  Copyright (c) 2014年 xxTeam. All rights reserved.
//

#import "CacheDAO.h"
#import "Cache.h"

@implementation CacheDAO

- (BOOL)create:(CacheModel *) cache{
    
    NSManagedObjectContext *ctx=[self managedObjectContext];
    
    Cache *c=[NSEntityDescription insertNewObjectForEntityForName:@"Cache" inManagedObjectContext:ctx];
    
    CacheDAO *dao=[CacheDAO new];
    NSDictionary *dictionary=[dao getjsonByRemote:cache.remoteURL];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    if (dictionary!=nil) {
        NSLog(@"正在更新缓存");
        [archiver encodeObject:dictionary forKey:@"json"];
        [archiver finishEncoding];
    }
    else
    {
        NSLog(@"新建缓存");
        [archiver encodeObject:cache.returnJson forKey:@"json"];
        [archiver finishEncoding];
    }
    c.remoteURL = cache.remoteURL;
    c.expiryDate = cache.expiryDate;
    c.returnJson = data;
    
    NSError *error = nil;
    BOOL isSave =   [self.managedObjectContext save:&error];
    if (!isSave) {
        NSLog(@"error:%@,%@",error,[error userInfo]);
        return NO;
    }
    else{
        NSLog(@"缓存保存成功");
        
    }
    return YES;
    
}

- (NSDictionary *)getjsonByRemote:(NSString*)url
{
    NSManagedObjectContext *cxt=[self managedObjectContext];
    
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Cache" inManagedObjectContext:cxt];
    
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    //NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:"" ascending:<#(BOOL)#>]
    NSPredicate *TypePredicate = [NSPredicate predicateWithFormat:@"remoteURL =%@",url];
    [request setPredicate:TypePredicate];
    NSError *error=nil;
    NSArray *listData=[cxt executeFetchRequest:request error:&error];
    if ([listData count]>0) {
        Cache *cache=[listData lastObject];
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:cache.returnJson];
        NSDictionary *json = [unarchiver decodeObjectForKey:@"json"];
        [unarchiver finishDecoding];
        return json;
    }
    return nil;
}
//
//- (NSMutableArray *)findPlanBySportID:(NSString *)sportID {
//
//    NSManagedObjectContext *cxt=[self managedObjectContext];
//
//    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Pic" inManagedObjectContext:cxt];
//
//    NSFetchRequest *request=[[NSFetchRequest alloc] init];
//    [request setEntity:entityDescription];
//
//    //NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:"" ascending:<#(BOOL)#>]
//    NSPredicate *TypePredicate = [NSPredicate predicateWithFormat:@"sportID =%@",sportID];
//    [request setPredicate:TypePredicate];
//    NSError *error=nil;
//    NSArray *listData=[cxt executeFetchRequest:request error:&error];
//    NSMutableArray *resListData=[[NSMutableArray alloc] init];
//
//    for(Pic *model in listData)
//    {
//        PicObject *list=[[PicObject alloc] init];
//
//        list.gps = model.gps;
//        list.sportID = model.sportID;
//        list.picname = model.picname;
//        list.timestamp = model.timestamp;
//        list.dirty=model.dirty;
//        list.del=model.del;
//        list.picID=model.picID;
//
//        [resListData addObject:list];
//    }
//    return resListData;
//
//
//}
//
//-(BOOL)isExistImage:(NSString *)sportID
//{
//    NSManagedObjectContext *cxt=[self managedObjectContext];
//
//    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Pic" inManagedObjectContext:cxt];
//
//    NSFetchRequest *request=[[NSFetchRequest alloc] init];
//    [request setEntity:entityDescription];
//
//    NSPredicate *TypePredicate = [NSPredicate predicateWithFormat:@"sportID =%@",sportID];
//    [request setPredicate:TypePredicate];
//    NSError *error=nil;
//    NSArray *listData=[cxt executeFetchRequest:request error:&error];
//    if([listData count]>0)
//    {
//        return YES;
//    }
//    return NO;
//
//
//}
//
//
//-(NSArray*)getDirtyPic
//{
//    NSManagedObjectContext *cxt=[self managedObjectContext];
//    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Pic" inManagedObjectContext:cxt];
//
//    NSFetchRequest *request=[[NSFetchRequest alloc] init];
//    [request setEntity:entityDescription];
//
//    NSPredicate *TypePredicate = [NSPredicate predicateWithFormat:@"dirty =1"];
//    [request setPredicate:TypePredicate];
//    NSError *error=nil;
//    NSArray *listData=[cxt executeFetchRequest:request error:&error];
//    NSMutableArray *resListData=[[NSMutableArray alloc] init];
//
//    for(Pic *model in listData)
//    {
//        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
//
//        [dic setValue:model.gps forKey:@"gps"];
//        [dic setValue:model.sportID forKey:@"sportID"];
//        [dic setValue:model.picname forKey:@"pictureName"];
//        [dic setValue:model.timestamp forKey:@"timestamp"];
//        [dic setValue:model.dirty forKey:@"dirty"];
//        [dic setValue:model.del forKey:@"dele"];
//        [dic setValue:model.picID forKey:@"pictureID"];
//
//
//        [resListData addObject:dic];
//    }
//    return resListData;
//}
@end
