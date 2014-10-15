//
//  RankDetailViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "RankDetailViewController.h"
#import "RankDetailModel.h"
#import "RankDetailTableViewCell.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@interface RankDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    NSArray *rankList;
    NSString *valueNamel;
}
@end

@implementation RankDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _table=[[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    _table.delegate=self;
    _table.dataSource=self;
    [self.view addSubview:_table];
    [self getDetail];
}


- (void)getDetail
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSLog(@"%d",_ID);
    [manager POST:[NSString stringWithFormat:@"http://300report.jumpw.com/api/getrank?type=%d",_ID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSString *result=[responseObject objectForKey:@"Result"];
        if([result isEqualToString:@"OK"])
        {
            NSDictionary *Rank=[responseObject objectForKey:@"Rank"];
            self.title=[Rank objectForKey:@"Title"];
            valueNamel=[Rank objectForKey:@"ValueName"];
             NSArray *List=[Rank objectForKey:@"List"];
            
            NSMutableArray *tempArray=[[NSMutableArray alloc] init];
            for (NSDictionary *temp in List) {
            RankDetailModel *model=[[RankDetailModel alloc] init];
                model.Index=[[temp objectForKey:@"Index"] integerValue];
                model.Name=[temp objectForKey:@"Name"];
                model.RankChange=[[temp objectForKey:@"RankChange"] integerValue];
                model.Url=[temp objectForKey:@"Url"];
                model.Value=[[temp objectForKey:@"Value"] integerValue];
                [tempArray addObject:model];
            }
            
            rankList=tempArray;
            [_table reloadData];
        }
        //dataArray=tempArray;
        //[self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}




#pragma mark UITableViewDelagate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [rankList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier=@"RankDetailCell";
    RankDetailTableViewCell *cell=[[RankDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
   
    
    [cell configCell:rankList[indexPath.row]];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    UILabel *NOlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 30)];
    NOlabel.text=@"名次";
    NOlabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:NOlabel];
    
    UILabel *labelName=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 110, 30)];
    labelName.text=@"召唤师";
    labelName.textAlignment=NSTextAlignmentCenter;
    [view addSubview:labelName];
    
    
    UILabel *value=[[UILabel alloc] initWithFrame:CGRectMake(180, 10, 60, 30)];
    value.text=valueNamel;
    [view addSubview:value];
    
    UILabel *change=[[UILabel alloc] initWithFrame:CGRectMake(260, 10, 40, 30)];
    change.textAlignment=NSTextAlignmentRight;
    change.text=@"变动";
    
    [view addSubview:change];
    [view setBackgroundColor:[UIColor grayColor]];
    return view;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
