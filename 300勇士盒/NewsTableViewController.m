//
//  NewsTableViewController.m
//  300勇士盒
//
//  Created by ChenHao on 12/8/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsTableViewCell.h"
#import "HeaderScrollView.h"
#import "UConstants.h"
#import "MJRefresh.h"




@interface NewsTableViewController ()
@property (nonatomic,strong) HeaderScrollView *header;
@property (nonatomic, assign) NSInteger count;

@end

@implementation NewsTableViewController



- (instancetype)initWithHeader:(NSInteger)NewsType
{
    self=[super initWithStyle:UITableViewStylePlain];
    if (self) {
        _header=[[HeaderScrollView alloc] initWithFrame:CGRectMake(0,0, Main_Screen_Width, 150)];
        self.tableView.tableHeaderView=_header;
        
    }
    return self;
}

- (instancetype)initWithHeaderWithoutHeader:(NSInteger)NewsType
{
    self=[super initWithStyle:UITableViewStylePlain];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _count=10;
    [self steup];
    
    
  
}

- (void)steup
{

    //[self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
     __weak NewsTableViewController *weakSelf = self;
     [self.tableView addHeaderWithCallback:^{
         [weakSelf headerRereshing];
     }];
    //[self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithCallback:^{
        [weakSelf footerRereshing];
    }];
    
//    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
//    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
//    self.tableView.headerRefreshingText = @"MJ哥正在帮你刷新中,不客气";
//    
//    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
//    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
//    self.tableView.footerRefreshingText = @"MJ哥正在帮你加载中,不客气";
}

#pragma mark Refreshing
- (void)headerRereshing
{
    [self.tableView headerEndRefreshing];
}

- (void)footerRereshing
{
    _count+=10;
    [self.tableView reloadData];
    [self.tableView footerEndRefreshing];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifer=@"newsidentifer";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(cell==nil)
    {
        cell=[[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [_header.timer invalidate];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
