//
//  RankTypeTableViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "RankTypeTableViewController.h"
#import "UIViewController+CHSideMenu.h"
#import "RankTypeModel.h"
#import "RankTypeTableViewCell.h"
#import "RankDetailViewController.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
@interface RankTypeTableViewController ()
{
    NSArray *dataArray;
}

@end

@implementation RankTypeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"排行榜";
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1] forKey:NSForegroundColorAttributeName];
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"burger"] style:UIBarButtonItemStyleDone target:self action:@selector(toogleMenu)];
    self.navigationItem.leftBarButtonItem=left;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getData
{
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
        NSLog(@"%@",tempArray);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)toogleMenu
{
    [self.navigationController.sideMenuController toggleMenu:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier=@"RankIdentifier";
    RankTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell==nil)
    {
        cell=[[RankTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    RankTypeModel *model=dataArray[indexPath.row];
    cell.RankID=model.getRankType;
    // Configure the cell...
    cell.textLabel.text=model.Name;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankTypeTableViewCell *cell=(RankTypeTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%ld",(long)cell.RankID);
    RankDetailViewController *rank=[[RankDetailViewController alloc] init];
    rank.ID=cell.RankID;
    [self.navigationController pushViewController:rank animated:YES];
}
@end
