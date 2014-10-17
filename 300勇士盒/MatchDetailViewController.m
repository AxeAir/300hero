//
//  MatchDetailViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/13/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "MatchDetailViewController.h"
#import <AFHTTPRequestOperationManager.h>
#import "MatchDetailModel.h"
#import "MatchDetailView.h"
#import "UConstants.h"
@interface MatchDetailViewController ()<MatchDeailViewDelegate>
{
    MatchDetailModel *matchData;
}

@end

@implementation MatchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"战斗详情";
    self.view.backgroundColor=[UIColor whiteColor];
    _scrollView=[[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_scrollView setBackgroundColor:[UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1]];
    [_scrollView setContentSize:CGSizeMake(320, 1700)];
    [_scrollView setBackgroundColor:BACKGROUND_COLOR];
    [_scrollView setUserInteractionEnabled:YES];
    [self.view addSubview:_scrollView];
    [self getDetailMatch];
}


-(void)getDetailMatch
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain", nil];
    NSDictionary *paremeters=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lu",(unsigned long)_MatchID],@"id", nil];
    [manager GET:@"http://300report.jumpw.com/api/getmatch" parameters:paremeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *result=[responseObject objectForKey:@"Result"];
        if([result isEqualToString:@"OK"])
        {
            MatchDetailModel *model=[[MatchDetailModel alloc] init];
            NSDictionary *Match=[responseObject objectForKey:@"Match"];
            [model parseFromObject:Match];
            matchData=model;
            [self drawTheMatchDetail:model];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)drawTheMatchDetail:(MatchDetailModel*)match
{
    
    UILabel *wincount=[[UILabel alloc] initWithFrame:CGRectMake(50, 60, 40, 30)];
    wincount.text=[NSString stringWithFormat:@"%lu",(unsigned long)match.WinSideKill];
    wincount.font=[UIFont systemFontOfSize:30];
    wincount.textColor=[UIColor greenColor];
    [_scrollView addSubview:wincount];
    
    UILabel *losecount=[[UILabel alloc] initWithFrame:CGRectMake(230, 60, 40, 30)];
    losecount.text=[NSString stringWithFormat:@"%lu",(unsigned long)match.LoseSideKill];
    losecount.font=[UIFont systemFontOfSize:30];
    losecount.textColor=[UIColor redColor];
    [_scrollView addSubview:losecount];
    
    UILabel *datetime=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 300, 30)];
    datetime.font=[UIFont systemFontOfSize:16];
    datetime.textColor=RGBCOLOR(136, 187, 225);
    datetime.text=[NSString stringWithFormat:@"游戏日期:%@",match.MatchDate];
    [_scrollView addSubview:datetime];
    
    UILabel *time=[[UILabel alloc] initWithFrame:CGRectMake(5, 25, 200, 30)];
    time.font=[UIFont systemFontOfSize:16];
    time.textColor=RGBCOLOR(136, 187, 225);
    time.text=match.getUseTime;
    [_scrollView addSubview:time];
    
    UILabel *win=[[UILabel alloc] initWithFrame:CGRectMake(10, 95, 200, 30)];
    win.font=[UIFont systemFontOfSize:20];
    win.textColor=[UIColor greenColor];
    win.text=@"胜利队伍";
    [_scrollView addSubview:win];
    
    
    UIImageView *vs=[[UIImageView alloc] initWithFrame:CGRectMake(115, 50, 90, 46)];
    vs.image=[UIImage imageNamed:@"vs"];
    [_scrollView addSubview:vs];
    
    
    int i=0;
    for (RoleModel *model in match.winSide) {
        MatchDetailView *view=[[MatchDetailView alloc] initWithFrame:CGRectMake(0, 120+100*i, 320, 100)];
        [view setUserInteractionEnabled:YES];
        view.delegate=self;
        [view configView:model];
        [_scrollView addSubview:view];
        i++;
    }
    
    UILabel *lose=[[UILabel alloc] initWithFrame:CGRectMake(10, 860, 200, 30)];
    lose.font=[UIFont systemFontOfSize:20];
    lose.textColor=[UIColor redColor];
    lose.text=@"失败队伍";
    [_scrollView addSubview:lose];
    i=0;
    for (RoleModel *model in match.loseSide) {
        MatchDetailView *view=[[MatchDetailView alloc] initWithFrame:CGRectMake(0, 880+100*i, 320, 100)];
        
        [view configView:model];
        [_scrollView addSubview:view];
        i++;
    }
    
  
}

-(void)didClickHeaderView:(NSString *)name
{
    _other=[[OtherViewController alloc] initWithName:name];
    
    [self.navigationController pushViewController:_other animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
