//
//  HeroViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "HeroViewController.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "HeroModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HeroViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *HeroList;
}

@end

@implementation HeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"英雄";
    self.view.backgroundColor=[UIColor whiteColor];
    
    _table=[[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    _table.delegate=self;
    _table.dataSource=self;
    [self.view addSubview:_table];
    [self getHeroList];
}

-(void)getHeroList
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];
    [manager GET:@"http://218.244.143.212:2015/getAllHeros" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSMutableArray *tempArray=[[NSMutableArray alloc] init];
        NSString *Result=[responseObject objectForKey:@"Result"];
        NSArray *hero=[[NSArray alloc] init];
        if([Result isEqualToString:@"OK"])
        {
            hero=[responseObject objectForKey:@"HeroList"];
            int i=1;
            NSMutableArray *three=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in hero) {
                
                HeroModel *model=[[HeroModel alloc] init];
                model.HeroID=[[dic objectForKey:@"id"] integerValue];
                model.ImgURL=[dic objectForKey:@"imgUrl"];
                model.HeroName=[dic objectForKey:@"name"];
                if(i%4!=0)
                {
                    [three addObject:model];
                }
                else
                {
                    [three addObject:model];
                    [tempArray addObject:three];
                    three=[[NSMutableArray alloc] init];
                }
                i++;
            }
            if(three!=nil)
            {
                 [tempArray addObject:three];
            }
            
            HeroList=tempArray;
            [_table reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
        
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //不让tableviewcell有选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",[HeroList[0] count]);
    
    return [HeroList count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSArray *heroThree=HeroList[indexPath.row];
    int i=0;
    for (HeroModel *model in heroThree) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(10+75*i+5, 10, 65, 80)];
        //view.backgroundColor=[UIColor redColor];
        UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 55, 55)];
        NSString *url=[NSString stringWithFormat:@"http://218.244.143.212:2015/static/%@",model.ImgURL];
        [image sd_setImageWithURL:[NSURL URLWithString:url]
              placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        UILabel *labelName=[[UILabel alloc] initWithFrame:CGRectMake(5, 60, 55, 15)];
        labelName.text=model.HeroName;
        labelName.font=[UIFont systemFontOfSize:10];
        labelName.textAlignment=NSTextAlignmentCenter;
        [view addSubview:labelName];
        [view addSubview:image];
        [cell addSubview:view];
        i++;
        //NSLog(@"%d",i);
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
