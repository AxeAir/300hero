//
//  NewsWebViewController.m
//  300勇士盒
//
//  Created by ChenHao on 12/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "NewsWebViewController.h"
#import "UConstants.h"
#import "ReviewTableViewController.h"
#import "CacheEntence.h"

@interface NewsWebViewController ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) NSInteger pageID;
@end

@implementation NewsWebViewController

- (instancetype)initWithPageID:(NSInteger)pageID
{
    self=[super init];
    if(self)
    {
        _pageID = pageID;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"详情";
    [self layout];
}


//http://219.153.64.13:8520/getPageDetail/?pageID=1
-(void)layout
{
    _webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@getPageDetail/?pageID=%ld",DEBUG_URL,(long)_pageID]];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    
    
    //导航栏
    UIButton *review = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 50, 20)];
    [review setTitle:@"评论" forState:UIControlStateNormal];
    
    
    UIView *tabBar = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height-40-64, Main_Screen_Width, 40)];
    [tabBar setBackgroundColor:BACKGROUND_COLOR];
    //[tabBar setBackgroundColor:[UIColor whiteColor]];
    
//    UIButton *likeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width/3, 40)];
//    [likeButton setTitle:@"赞" forState:UIControlStateNormal];
//    [likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [tabBar addSubview:likeButton];
    
    
    UIButton *reviewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
    [reviewButton setTitle:@"评论" forState:UIControlStateNormal];
    [reviewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reviewButton addTarget:self action:@selector(review) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:reviewButton];

    [self.view addSubview:tabBar];
}



- (void)review
{
    ReviewTableViewController *review = [[ReviewTableViewController alloc] init];
    review.pageID=_pageID;
    [self.navigationController pushViewController:review animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
