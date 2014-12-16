//
//  LXTableViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/21/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "LXTableViewController.h"
#import "UConstants.h"
#import "UIViewController+CHSideMenu.h"
#import <AFHTTPRequestOperationManager.h>
#import "RankTypeModel.h"
#import "RankTypeTableViewCell.h"
#import "RankTypeTableViewController.h"
@interface LXTableViewController ()

@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation LXTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"大神榜";
    [self.view  setBackgroundColor:BACKGROUND_COLOR];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor blackColor];
    self.tableView.separatorInset=UIEdgeInsetsZero;
    
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1] forKey:NSForegroundColorAttributeName];
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"burger"] style:UIBarButtonItemStyleDone target:self action:@selector(toogleMenu)];
    self.navigationItem.leftBarButtonItem=left;
    
    [self getList];
}

- (void)toogleMenu
{
    [self.navigationController.sideMenuController toggleMenu:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getList
{
    self.manager=[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    
    [self.manager GET:[NSString stringWithFormat:@"%@getRank/?id=-1",DEBUG_URL]parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        self.dataArray=tempArray;
        //NSLog(@"%@",tempArray);
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier=@"RankIdentifier";
    RankTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell==nil)
    {
        cell=[[RankTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    [cell setBackgroundColor:BACKGROUND_COLOR];
    RankTypeModel *model=self.dataArray[indexPath.row];
    cell.RankID=model.getRankType;
    // Configure the cell...
    cell.textLabel.text=model.Name;
    cell.textLabel.textColor=RGBCOLOR(135, 186, 225);
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    RankTypeTableViewCell *cell=(RankTypeTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%ld",(long)cell.RankID);
    
    _detail=[[LXDetailViewController alloc] init];
    
    _detail.ID=indexPath.row;
    [self.navigationController pushViewController:_detail animated:YES];
    
    //    RankDetailViewController *rank=[[RankDetailViewController alloc] init];
    //    rank.ID=cell.RankID;
    //    [self.navigationController pushViewController:rank animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

@end
