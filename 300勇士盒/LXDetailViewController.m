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

#import "RankDetailTableViewCell.h"
#define HEADERBGCOLOR          [UIColor colorWithRed:24/255.0f green:40/255.0f blue:58/255.0f alpha:1]
#define HEADERTEXTCOLOR        [UIColor colorWithRed:107/255.0f green:145/255.0f blue:173/255.0f alpha:1]
#define CELLBG                 [UIColor colorWithRed:22/255.0f green:29/255.0f blue:38/255.0f alpha:1]

@interface LXDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *rankList;
    NSString *valueNamel;
    UILabel *labelName;
    NSString *indexName;
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
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSLog(@"%d",_ID);
    [manager GET:[NSString stringWithFormat:@"http://218.244.143.212:8520/getRank/?id=%ld",(long)_ID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSString *result=[responseObject objectForKey:@"Result"];
        if([result isEqualToString:@"OK"])
        {
            NSDictionary *Rank=[responseObject objectForKey:@"Rank"];
            self.title=[Rank objectForKey:@"Title"];
            valueNamel=[Rank objectForKey:@"ValueName"];
            indexName=[Rank objectForKey:@"IndexName"];
            NSArray *List=[Rank objectForKey:@"List"];
            
            NSMutableArray *tempArray=[[NSMutableArray alloc] init];
            for (NSDictionary *temp in List) {
                RankDetailModel *model=[[RankDetailModel alloc] init];
                model.Index=[[temp objectForKey:@"Index"] integerValue];
                model.Name=[temp objectForKey:@"name"];
                model.Value=[[temp objectForKey:@"Value"] integerValue];
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
    RankDetailTableViewCell *cell=[[RankDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    [cell configLXCell:rankList[indexPath.row]];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UILabel *NOlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 40, 30)];
    NOlabel.text=@"名次";
    NOlabel.textColor=HEADERTEXTCOLOR;
    NOlabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:NOlabel];
    
    labelName=[[UILabel alloc] initWithFrame:CGRectMake(80, 5, 110, 30)];
    labelName.text=indexName;
    labelName.textColor=HEADERTEXTCOLOR;
    labelName.textAlignment=NSTextAlignmentCenter;
    [view addSubview:labelName];
    
    
    UILabel *value=[[UILabel alloc] initWithFrame:CGRectMake(220, 5, 60, 30)];
    value.text=valueNamel;
    value.textColor=HEADERTEXTCOLOR;
    [view addSubview:value];

    [view setBackgroundColor:HEADERBGCOLOR];
    return view;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
