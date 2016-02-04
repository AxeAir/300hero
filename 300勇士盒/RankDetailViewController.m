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
#import "UConstants.h"
#define HEADERBGCOLOR          [UIColor colorWithRed:24/255.0f green:40/255.0f blue:58/255.0f alpha:1]
#define HEADERTEXTCOLOR        [UIColor colorWithRed:107/255.0f green:145/255.0f blue:173/255.0f alpha:1]
#define CELLBG                 [UIColor colorWithRed:22/255.0f green:29/255.0f blue:38/255.0f alpha:1]

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
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
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
    NSLog(@"%ld",(long)_ID);
    NSString *url = [NSString stringWithFormat:@"http://300report.jumpw.com/api/getrank?type=%ld",(long)_ID];
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        
        NSString *result=[responseObject objectForKey:@"Result"];
        if([result isEqualToString:@"OK"]) {
            NSDictionary *Rank=[responseObject objectForKey:@"Rank"];
            self.title=[Rank objectForKey:@"Title"];
            valueNamel=[Rank objectForKey:@"ValueName"];
            NSArray *List=[Rank objectForKey:@"List"];
            if (![List isEqual:[NSNull null]]) {
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
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UILabel *NOlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 40, 30)];
    NOlabel.text=@"名次";
    NOlabel.textColor=HEADERTEXTCOLOR;
    NOlabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:NOlabel];
    
    UILabel *labelName=[[UILabel alloc] initWithFrame:CGRectMake(50, 5, 110, 30)];
    labelName.text=@"召唤师";
    labelName.textColor=HEADERTEXTCOLOR;
    labelName.textAlignment=NSTextAlignmentCenter;
    [view addSubview:labelName];
    
    
    UILabel *value=[[UILabel alloc] initWithFrame:CGRectMake(180, 5, 60, 30)];
    value.text=valueNamel;
    value.textColor=HEADERTEXTCOLOR;
    [view addSubview:value];
    
    UILabel *change=[[UILabel alloc] initWithFrame:CGRectMake(260, 5, 40, 30)];
    change.textAlignment=NSTextAlignmentRight;
    change.textColor=HEADERTEXTCOLOR;
    change.text=@"变动";
    
    [view addSubview:change];
    [view setBackgroundColor:HEADERBGCOLOR];
    return view;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankDetailTableViewCell *cell=(RankDetailTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    _other=[[MainViewController alloc] initWithOtherHero:cell.rolename];
    [self.navigationController pushViewController:_other animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
