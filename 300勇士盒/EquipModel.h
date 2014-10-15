//
//  EquipModel.h
//  300勇士盒
//
//  Created by ChenHao on 10/13/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquipModel : NSObject

// 装备信息

@property (nonatomic,assign) NSUInteger  ID;           // ID
@property (nonatomic,strong) NSString    *Name;        // 名称
@property (nonatomic,strong) NSString    *IconFile;    // 图片相对路径.(在static/images/下)

@end
