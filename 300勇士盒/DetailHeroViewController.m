//
//  DetailHeroViewController.m
//  300勇士盒
//
//  Created by ChenHao on 12/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "DetailHeroViewController.h"
#import "CacheEntence.h"
#import "DetailHero.h"
#import "DetailHeader.h"
#import "UConstants.h"
#import "DetailDescription.h"
#import "HYSegmentedControl.h"

@interface DetailHeroViewController ()<HYSegmentedControlDelegate>

@property (nonatomic, assign) NSInteger heroID;
@property (nonatomic, assign) NSInteger cuuentSegment;

@property (nonatomic, strong) CacheEntence *entence;
@property (nonatomic, strong) HYSegmentedControl *segment;
@property (nonatomic, strong) DetailHero *hero;
@property (nonatomic, strong) DetailDescription *content;
@property (nonatomic, strong) DetailHeader *header;

@end

@implementation DetailHeroViewController

- (instancetype) initWithHeroID:(NSInteger)heroID
{
    self=[super init];
    if (self) {
        _heroID=heroID;
        _entence=[CacheEntence new];
        _cuuentSegment = 0;
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}

- (void)getData
{
    NSString *URL=[NSString stringWithFormat:@"http://219.153.64.13:8520/getHeroDetail/?heroID=%ld",(long)_heroID];
    [_entence RequestRemoteURL:URL paramters:nil Cache:YES success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        _hero = [[DetailHero alloc] initWithDictionary:[responseObject objectForKey:@"Result"]];
        NSLog(@"%@",_hero);
        [self layout];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)layout
{
    [self.view  setBackgroundColor:[UIColor whiteColor]];
     _header=[[DetailHeader alloc] initWithHero:_hero];
    [_header setFrame:CGRectMake(0, 0, Main_Screen_Width, 80)];
    [self.view addSubview:_header];
    
    
    _segment=[[HYSegmentedControl alloc] initWithOriginY:80 Titles:@[@"技能", @"出装", @"介绍"] delegate:self];
    _segment.delegate=self;
    [self.view addSubview:_segment];
    
    
    _content=[[DetailDescription alloc] initWithHero:_hero type:_cuuentSegment];
    [_content setFrame:CGRectMake(0, MaxY(_segment), Main_Screen_Width, Main_Screen_Height-HEIGHT(_header))];
    [self.view addSubview:_content];
    
    
}

-(void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    if (index==_cuuentSegment) {
        
    }
    else
    {
        _cuuentSegment=index;
    }
    
    [_content removeFromSuperview];
    _content=[[DetailDescription alloc] initWithHero:_hero type:_cuuentSegment];
    [_content setFrame:CGRectMake(0, MaxY(_segment), Main_Screen_Width, Main_Screen_Height-HEIGHT(_header))];
    [self.view addSubview:_content];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
