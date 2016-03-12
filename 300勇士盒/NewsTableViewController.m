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
#import <AFHTTPRequestOperationManager.h>
#import "NewsModel.h"
#import "NewsWebViewController.h"
#import "CacheDAO.h"
#import "CacheEntence.h"

#import <MediaPlayer/MediaPlayer.h>


@interface NewsTableViewController ()
@property (nonatomic,strong ) HeaderScrollView  *header;
@property (nonatomic, assign) NSInteger          count;
@property (nonatomic, strong) NSArray           *newsData;
@property (nonatomic, assign) NSInteger          newsType;




@end

@implementation NewsTableViewController



- (instancetype)initWithHeader:(NSInteger)NewsType
{
    self=[super initWithStyle:UITableViewStylePlain];
    if (self) {
        _header=[[HeaderScrollView alloc] initWithFrame:CGRectMake(0,0, Main_Screen_Width, 150)];
    self.tableView.tableHeaderView            = _header;
    _newsType                                 = NewsType;
        [self getDate:NewsType endRefresh:NO cache:YES];
    }
    return self;
}

- (instancetype)initWithHeaderWithoutHeader:(NSInteger)NewsType
{
    self=[super initWithStyle:UITableViewStylePlain];
    if (self) {
    _newsType                                 = NewsType;
        [self getDate:NewsType endRefresh:NO cache:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _count = 10;
    [self steup];

}


- (void)getDate:(NSInteger)NewsType endRefresh:(BOOL)endRefresh cache:(BOOL)cache {
    NSString *url=[NSString stringWithFormat:@"%@/getPageList/?newsType=%ld",DEBUG_URL,(long)NewsType];
    [CacheEntence RequestRemoteURL:url paramters:nil Cache:cache success:^(id responseObject) {

        NSLog(@"%@",responseObject);
        _newsData=[NewsModel getlatestNews:[responseObject objectForKey:@"Result"]];

        if (NewsType==0) {
            [_header setHeaderImage:_newsData];
        }

        if (endRefresh) {
            [self.tableView headerEndRefreshing];
        }
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        if (endRefresh) {
            [self.tableView headerEndRefreshing];
        }
    }];


}


- (void)pullUp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NewsModel *news=[_newsData lastObject];

    NSString *url=[NSString stringWithFormat:@"%@/getPageList/?newsType=%ld&&index=%ld",DEBUG_URL,(long)_newsType,(long)news.newsid];

    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);

        NSString *status=[responseObject objectForKey:@"Status"];
        if ([status isEqualToString:@"OK"]) {

            NSArray *temp10=[NewsModel getlatestNews:[responseObject objectForKey:@"Result"]];
            NSMutableArray *current=[[NSMutableArray alloc] initWithArray:_newsData];
            [current addObjectsFromArray:temp10];
    _newsData                                 = current;

            CacheDAO *dao=[CacheDAO new];
            CacheModel *model=[[CacheModel alloc] init];
    model.remoteURL                           = url;
            model.returnJson=(NSDictionary*)responseObject;
            [dao create:model];
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];

        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self.tableView footerEndRefreshing];
    }];

}

- (void)steup
{

    //[self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    __weak NewsTableViewController *weakSelf  = self;
     [self.tableView addHeaderWithCallback:^{
         [weakSelf headerRereshing];
     }];
    //[self.tableView headerBeginRefreshing];

    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithCallback:^{
        [weakSelf footerRereshing];
    }];

//    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText    = @"下拉可以刷新噢";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新噢";
    self.tableView.headerRefreshingText       = @"正在疯狂刷新中";

    self.tableView.footerPullToRefreshText    = @"上拉可以加载更多数据噢";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据噢";
    self.tableView.footerRefreshingText       = @"正在疯狂加载中";
}

#pragma mark Refreshing
- (void)headerRereshing
{
    [self getDate:_newsType endRefresh:YES cache:NO];
}

- (void)footerRereshing
{
    [self pullUp];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_newsData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifer=@"newsidentifer";
    NewsTableViewCell *cell                   = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(cell==nil)
    {
        cell=[[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    else
    {
        for (UIView *v in cell.contentView.subviews) {
            [v removeFromSuperview];
        }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    [cell layout:[_newsData objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_newsType==NewsTypeVIDEO) {

    NewsModel *news                           = [_newsData objectAtIndex:indexPath.row];
        NSLog(@"%@",news.url);
        NSURL *url=[NSURL URLWithString:news.url];
        [_delegate openVideo:url];
    }
    else{
    NewsModel *news                           = [_newsData objectAtIndex:indexPath.row];
        [_delegate clickcell2web:news.newsid];
    }


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
