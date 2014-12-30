//
//  CacheEntence.h
//  300勇士盒
//
//  Created by ChenHao on 12/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheEntence : NSObject


- (NSDictionary *)RequestRemoteURL:(NSString *)url;


+ (void)RequestRemoteURL:(NSString *)url paramters:(NSDictionary *) paramters Cache:(BOOL)cache success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
