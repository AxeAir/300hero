//
//  MainViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "MainViewController.h"
#import "UIViewController+CHSideMenu.h"
#import "CHHeader.h"
#import "MatchModel.h"
#import "MatchDetailViewController.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "MatchTableViewCell.h"
@interface MainViewController ()<CHScaleHeaderDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CHHeader *_header;
    NSArray *MatchData;
}

@property (nonatomic,strong) NSUserDefaults *userdefault;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    //self.title=@"战绩";
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1] forKey:NSForegroundColorAttributeName];
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"burger"] style:UIBarButtonItemStyleDone target:self action:@selector(toogleMenu)];
    self.navigationItem.leftBarButtonItem=left;
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem=right;
    
    self.navigationItem.titleView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    
    self.userdefault=[NSUserDefaults standardUserDefaults];
    
    NSString *rolename=[self.userdefault objectForKey:@"DefaultRole"];
    //[self.userdefault setObject:@"枫血" forKey:@"DefaultRole"];
    if(rolename==nil)
    {
        //[self notHaveRoleName];
        [self havaRoleName:@"枫血"];
    }
    else
    {
        [self havaRoleName:rolename];
    }

}

- (void)havaRoleName:(NSString*)rolename
{
    _scrollView=[[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_scrollView setContentSize:CGSizeMake(320, 1900)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    [imageView setImage:[UIImage imageNamed:@"indexbg"]];
    
    //[_scrollView setContentSize:CGSizeMake(0, 600)];
    
    //_header = [CHHeader initWithView:_scrollView headerView:imageView];
    //_header.delegate=self;
    [_scrollView addSubview:imageView];
    [self.view addSubview:_scrollView];
    
    UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(30, 20, 110, 100)];
    name.text=rolename;
    name.textColor=[UIColor whiteColor];
    name.font=[UIFont systemFontOfSize:20];
    
    [_scrollView addSubview:name];
    
    
    UILabel *basiclabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 190, 300, 20)];
    basiclabel.text=@"战绩统计";
    basiclabel.font=[UIFont systemFontOfSize:14];
    basiclabel.textColor=[UIColor grayColor];
    [_scrollView addSubview:basiclabel];
    
    
    
    
    UILabel *basic=[[UILabel alloc] initWithFrame:CGRectMake(10, 300, 300, 20)];
    basic.text=@"最近比赛";
    basic.font=[UIFont systemFontOfSize:14];
    basic.textColor=[UIColor grayColor];
    [_scrollView addSubview:basic];
    
    _recentMatch=[[UITableView alloc] initWithFrame:CGRectMake(10, 330, 300, 500) style:UITableViewStylePlain];
    
    _recentMatch.delegate=self;
    _recentMatch.dataSource=self;
    
    [_scrollView addSubview:_recentMatch];
    
    [self getRecentMatch:rolename];
}


-(void)getRecentMatch:(NSString*)rolename
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain", nil];
    NSDictionary *paremeters=[NSDictionary dictionaryWithObjectsAndKeys:rolename,@"name", nil];
    [manager GET:@"http://300report.jumpw.com/api/getlist" parameters:paremeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *result=[responseObject objectForKey:@"Result"];
        if([result isEqualToString:@"OK"])
        {
            NSArray *List=[responseObject objectForKey:@"List"];
            NSMutableArray *dataTemp=[[NSMutableArray alloc] init];
            for (NSDictionary *match in List) {
                MatchModel *model=[[MatchModel alloc] initWithDictionary:match];
                [dataTemp addObject:model];
            }
            MatchData=dataTemp;
            [_recentMatch reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)notHaveRoleName
{
    UILabel *laber=[[UILabel alloc] initWithFrame:CGRectMake(30, 30, 260, 30)];
    laber.text=@"尚未添加默认角色,请添加";
    laber.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:laber];
    
    _searchName=[[UITextField alloc] initWithFrame:CGRectMake(10, 70, 300, 40)];
    _searchName.layer.borderColor = [UIColor grayColor].CGColor;
    
    _searchName.layer.borderWidth =1.0;
    _searchName.layer.cornerRadius =5.0;
    _searchName.delegate=self;
    [self.view addSubview:_searchName];
    
    UIButton *searchButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [searchButton setFrame:CGRectMake(10, 120, 300, 40)];
    searchButton.backgroundColor=[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:1];
    [searchButton setTitle:@"添加" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(addDefault) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //NSLog(@"fff");
    if (![_searchName isExclusiveTouch]) {
        [_searchName resignFirstResponder];
    }
}

- (void)addDefault
{
    if([_searchName.text length]==0)
    {
        NSLog(@"%@",_searchName.text);
    }
    else{
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain", nil];
        NSDictionary *parameters=[NSDictionary dictionaryWithObjectsAndKeys:_searchName.text,@"name", nil];
        [manager POST:@"http://300report.jumpw.com/api/getrole" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            NSString *Result=[responseObject objectForKey:@"Result"];
            if([Result isEqualToString:@"OK"])
            {
                NSDictionary *Role=[responseObject objectForKey:@"Role"];
                NSLog(@"%@",Role);
                
                NSString *RoleName=[Role objectForKey:@"RoleName"];
                [self.userdefault setObject:RoleName forKey:@"DefaultRole"];
                
            }
            else
            {
                NSLog(@"no");
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    }
    
    
}

-(void)search
{
    
}





- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)DidStartScaleHeader
{
    
}

-(void)DidEndScaleHeader
{
    
}


- (void)toogleMenu
{
    [self.navigationController.sideMenuController toggleMenu:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UItableView


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [MatchData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer=@"MatchCell";
    MatchTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if(cell==nil)
    {
        cell=[[MatchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    MatchModel *model=MatchData[indexPath.row];
    [cell config:model];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MatchTableViewCell *cell=(MatchTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    //NSLog(@"%d",cell.MatchID);
    MatchDetailViewController *match=[[MatchDetailViewController alloc] init];
    match.MatchID=cell.MatchID;
    [self.navigationController pushViewController:match animated:YES];
}

-(void)dealloc
{
    if(_scrollView)
    {
        //[_scrollView removeObserver:[CHHeader new] forKeyPath:@"contentOffset"];
        //_scrollView=nil;
    }
    //_headerView=nil;
}


@end
