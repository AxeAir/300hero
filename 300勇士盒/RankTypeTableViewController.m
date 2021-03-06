//
//  RankTypeTableViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "RankTypeTableViewController.h"
#import "RankTypeModel.h"
#import "RankTypeTableViewCell.h"
#import "RankDetailViewController.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "UConstants.h"
#import <AVOSCloud/AVOSCloud.h>
@interface RankTypeTableViewController () {
    NSArray *dataArray;
}

@end

@implementation RankTypeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排行榜";
 
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor blackColor];
    self.tableView.separatorInset=UIEdgeInsetsZero;
    [self.tableView setBackgroundColor:BACKGROUND_COLOR];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [self getData];
}

- (void)viewWillAppear:(BOOL)animated {
    [AVAnalytics beginLogPageView:@"排名页面"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [AVAnalytics endLogPageView:@"排名页面"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)getData {
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager POST:@"http://300report.jumpw.com/api/getrank?type=-1" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *Rank=[responseObject objectForKey:@"Rank"];
        NSArray *List=[Rank objectForKey:@"List"];
        
        NSMutableArray *tempArray=[[NSMutableArray alloc] init];
        for (NSDictionary *temp in List) {
            RankTypeModel *model=[[RankTypeModel alloc] init];
            model.Index=[[temp objectForKey:@"Index"] integerValue];
            model.Name=[temp objectForKey:@"Name"];
            model.RankChange=[[temp objectForKey:@"RankChange"] integerValue];
            model.Url=[temp objectForKey:@"Url"];
            model.Value=[temp objectForKey:@"Value"];
            [tempArray addObject:model];
        }
        dataArray=tempArray;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier=@"RankIdentifier";
    RankTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell == nil) {
        cell=[[RankTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    [cell setBackgroundColor:BACKGROUND_COLOR];
    RankTypeModel *model=dataArray[indexPath.row];
    cell.RankID=model.getRankType;
    cell.textLabel.text=model.Name;
    cell.textLabel.textColor=RGBCOLOR(135, 186, 225);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RankTypeTableViewCell *cell=(RankTypeTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%ld",(long)cell.RankID);
    RankDetailViewController *rank=[[RankDetailViewController alloc] init];
    rank.ID = cell.RankID;
    rank.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:rank animated:YES];
}

@end
