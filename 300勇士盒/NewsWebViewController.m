//
//  NewsWebViewController.m
//  300勇士盒
//
//  Created by ChenHao on 12/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "NewsWebViewController.h"
#import "UConstants.h"

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
        _pageID=pageID;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
