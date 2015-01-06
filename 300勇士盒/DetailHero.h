//
//  DetailHero.h
//  300勇士盒
//
//  Created by ChenHao on 12/15/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailHero : NSObject

@property (nonatomic, strong) NSString  *atk_type;
@property (nonatomic, strong) NSString  *desc;
@property (nonatomic, strong) NSString  *img;
@property (nonatomic, strong) NSString  *name;
@property (nonatomic, strong) NSString  *type;

@property (nonatomic, assign) NSInteger atk;
@property (nonatomic, assign) NSInteger atk_gu;
@property (nonatomic, assign) NSInteger cri;
@property (nonatomic, assign) NSInteger cri_gu;
@property (nonatomic, assign) NSInteger dey;
@property (nonatomic, assign) NSInteger dey_gu;
@property (nonatomic, assign) NSInteger dis;
@property (nonatomic, assign) NSInteger dis_gu;
@property (nonatomic, assign) NSInteger free_type;
@property (nonatomic, assign) NSInteger grp_rec;
@property (nonatomic, assign) NSInteger hp;
@property (nonatomic, assign) NSInteger hp5;
@property (nonatomic, assign) NSInteger hp_gu;
@property (nonatomic, assign) NSInteger hp_rec;
@property (nonatomic, assign) NSInteger heroid;
@property (nonatomic, assign) NSInteger mov;
@property (nonatomic, assign) NSInteger mov_gu;
@property (nonatomic, assign) NSInteger mp;
@property (nonatomic, assign) NSInteger mp5;
@property (nonatomic, assign) NSInteger mp_gu;
@property (nonatomic, assign) NSInteger mp_rec;
@property (nonatomic, assign) NSInteger ope_rec;
@property (nonatomic, assign) NSInteger psy_rec;
@property (nonatomic, assign) NSInteger ref;
@property (nonatomic, assign) NSInteger ref_gu;
@property (nonatomic, strong) NSArray *skills;


- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
