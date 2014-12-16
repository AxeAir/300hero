//
//  CacheEntence.m
//  300勇士盒
//
//  Created by ChenHao on 12/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "CacheEntence.h"
#import "CacheDAO.h"
#import <AFHTTPRequestOperationManager.h>
@implementation CacheEntence




- (NSDictionary *)RequestRemoteURL:(NSString *)url
{
    return nil;
}

- (void)RequestRemoteURL:(NSString *)url paramters:(NSDictionary *) paramters Cache:(BOOL)cache success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
{
    //使用缓存
    if (cache) {
        CacheDAO *dao=[CacheDAO new];
        NSDictionary *dic=[dao getjsonByRemote:url];
        //存在缓存
        if (dic!=nil) {
            NSLog(@"存在缓存,调用缓存");
            success(dic);
        }
        else
        {
            //想用缓存但是没有，现下载再存起来
            AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
            [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                CacheDAO *dao=[CacheDAO new];
                CacheModel *model=[[CacheModel alloc] init];
                model.remoteURL=url;
                model.returnJson=(NSDictionary*)responseObject;
                [dao create:model];
                NSLog(@"不存在缓存,存入缓存");
                success(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failure(error);
            }];
        }
        
    }
    
    //不使用缓存
    else
    {
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            CacheDAO *dao=[CacheDAO new];
            CacheModel *model=[[CacheModel alloc] init];
            model.remoteURL=url;
            model.returnJson=(NSDictionary*)responseObject;
            [dao create:model];
            NSLog(@"不存在缓存,存入缓存");
            success(responseObject);
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(error);
        }];
        
    }
}





@end
