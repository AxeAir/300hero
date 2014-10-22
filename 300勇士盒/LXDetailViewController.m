//
//  LXDetailViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/22/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "LXDetailViewController.h"
#import "LXDetailTableViewCell.h"
#import <AFHTTPRequestOperationManager.h>
#import "RankDetailModel.h"
#import "UConstants.h"
#define HEADERBGCOLOR          [UIColor colorWithRed:24/255.0f green:40/255.0f blue:58/255.0f alpha:1]
#define HEADERTEXTCOLOR        [UIColor colorWithRed:107/255.0f green:145/255.0f blue:173/255.0f alpha:1]
#define CELLBG                 [UIColor colorWithRed:22/255.0f green:29/255.0f blue:38/255.0f alpha:1]

@interface LXDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *rankList;
    NSString *valueNamel;
}
@end

@implementation LXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0,Main_Screen_Width,Main_Screen_Height-64) style:UITableViewStylePlain];
    _table.delegate=self;
    _table.dataSource=self;
    _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _table.separatorColor = [UIColor blackColor];
    _table.separatorInset=UIEdgeInsetsZero;
    [_table setBackgroundColor:CELLBG];
    [self.view addSubview:_table];
    [self getDetail];
}

- (void)getDetail
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];
    NSLog(@"%d",_type);
    [manager GET:[NSString stringWithFormat:@"http://218.244.143.212:2015/getRankData?type=%ld",(long)_type] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        
        NSString *result=[responseObject objectForKey:@"Result"];
        if([result isEqualToString:@"OK"])
        {
            //NSDictionary *Rank=[responseObject objectForKey:@"Rank"];
           // self.title=[Rank objectForKey:@"Title"];
            //valueNamel=[Rank objectForKey:@"ValueName"];
            NSArray *List=[responseObject objectForKey:@"DataList"];
            
            NSMutableArray *tempArray=[[NSMutableArray alloc] init];
            for (NSDictionary *temp in List) {
                RankDetailModel *model=[[RankDetailModel alloc] init];
                model.Index=[[temp objectForKey:@"index"] integerValue];
                model.Name=[temp objectForKey:@"name"];
                model.Value=[[temp objectForKey:@"value"] integerValue];
                [tempArray addObject:model];
            }
            
            rankList=tempArray;
            [_table reloadData];
        }
        
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
    LXDetailTableViewCell *cell=[[LXDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    [cell configCell:rankList[indexPath.row]];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UILabel *NOlabel=[[UILabel alloc] initWithFrame:CGRectMake(30, 5, 40, 30)];
    NOlabel.text=@"名次";
    NOlabel.textColor=HEADERTEXTCOLOR;
    NOlabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:NOlabel];
    
    UILabel *labelName=[[UILabel alloc] initWithFrame:CGRectMake(80, 5, 110, 30)];
    labelName.text=@"召唤师";
    labelName.textColor=HEADERTEXTCOLOR;
    labelName.textAlignment=NSTextAlignmentCenter;
    [view addSubview:labelName];
    
    
    UILabel *value=[[UILabel alloc] initWithFrame:CGRectMake(240, 5, 100, 30)];
    value.text=valueNamel;
    value.textColor=HEADERTEXTCOLOR;
    if(_type==0)
    {
        value.text=@"连胜场数";
    }
    if(_type==1)
    {
        value.text=@"连负场数";
    }
    [view addSubview:value];
    

    [view setBackgroundColor:HEADERBGCOLOR];
    return view;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXDetailTableViewCell *cell=(LXDetailTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    _other=[[OtherViewController alloc] initWithName:cell.rolename];
    [self.navigationController pushViewController:_other animated:YES];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
