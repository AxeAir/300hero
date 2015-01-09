//
//  ReviewTableViewController.m
//  300勇士盒
//
//  Created by ChenHao on 1/3/15.
//  Copyright (c) 2015 xxTeam. All rights reserved.
//

#import "ReviewTableViewController.h"
#import "UConstants.h"
#import "WriteReviewViewController.h"
#import "CacheEntence.h"
#import "ReviewTableViewCell.h"
@interface ReviewTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ReviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self addTable];
    [self addReviewButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getData];
}


- (void)NoReview
{
     UILabel *noReview=[[UILabel alloc] initWithFrame:CGRectMake((Main_Screen_Width-300)/2, 100, 300, 100)];
    noReview.text = @"暂无评论，快来做第一个评论的人把";
    noReview.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:noReview];
}

- (void)getData
{
    NSDictionary *paramters=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",_pageID],@"pageID", nil];
    [CacheEntence RequestRemoteURL:[NSString stringWithFormat:@"%@getComment/",DEBUG_URL] paramters:paramters Cache:NO success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *status=[responseObject objectForKey:@"Status"];
        NSDictionary *commons=[responseObject objectForKey:@"Result"];
        if ([commons count]!=0&&[status isEqualToString:@"OK"]) {
            
            NSMutableArray *tempAttay=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in commons) {
                [tempAttay addObject:dic];
            }
            _dataSource=tempAttay;
            [_tableView reloadData];
            
        }
        else if([commons count]==0)
        {
            [self NoReview];
            
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)addTable
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height-64-40)];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}

- (void)addReviewButton
{
    UIButton *writeReview = [[UIButton alloc] initWithFrame:CGRectMake(0, Main_Screen_Height-64-40, Main_Screen_Width, 40)];
    [writeReview setTitle:@"我要写评论" forState:UIControlStateNormal];
    [writeReview setBackgroundColor:BACKGROUND_COLOR];
    [writeReview addTarget:self action:@selector(write) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:writeReview];
}

- (void)write
{
    WriteReviewViewController *write = [[WriteReviewViewController alloc] init];
    write.pageID=_pageID;
    [self.navigationController pushViewController:write animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer=@"reviewcell";
    ReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell = [[ReviewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    else
    {
        for (UIView *v in cell.contentView.subviews) {
            [v removeFromSuperview];
        }
    }
    
    NSDictionary *dic = [_dataSource objectAtIndex:indexPath.row];
    [cell config:dic];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReviewTableViewCell *cell = (ReviewTableViewCell*) [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}



@end
