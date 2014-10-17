//
//  OtherViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/17/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "OtherViewController.h"
#import "UIViewController+CHSideMenu.h"
#import "CHHeader.h"
#import "MatchModel.h"
#import "MatchDetailViewController.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "MatchTableViewCell.h"
#import "MJRefresh.h"
#import "RecentModel.h"
#import "AksStraightPieChart.h"
#import "PercentageChart.h"
#define NAME_COLOR                 [UIColor colorWithRed:220/255.0f green:187/255.0f blue:23/255.0f alpha:1]
@interface OtherViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    NSArray *MatchData;
    RecentModel *recentModel;
    PercentageChart *percent;
    NSString *role;
    
}

@property (nonatomic,strong) NSUserDefaults *userdefault;
@property (nonatomic,strong) AksStraightPieChart * straightPieChart;

@end

@implementation OtherViewController

-(id)initWithName:(NSString *)roleName
{
    self=[super init];
    if (self) {
        role=roleName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"战绩";
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1];
    [self loadTheData:role];
}

-(void)refresh
{
    [self viewDidLoad];
    [_scrollView headerEndRefreshing];
}

- (void)havaRoleName:(NSString*)rolename
{
    if(_scrollView==nil){
        _scrollView=[[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    [_scrollView setContentSize:CGSizeMake(320, 1000)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    [imageView setImage:[UIImage imageNamed:@"indexbg"]];
    //[_scrollView setContentSize:CGSizeMake(0, 600)];
    
    //_header = [CHHeader initWithView:_scrollView headerView:imageView];
    //_header.delegate=self;
    [_scrollView addSubview:imageView];
    [self.view addSubview:_scrollView];
    __block OtherViewController *blockSelf = self;
    [_scrollView addHeaderWithCallback:^{
        [blockSelf refresh];
    }];
    
    UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(30, 100, 300, 100)];
    name.text=rolename;
    name.textColor=NAME_COLOR;
    name.font=[UIFont boldSystemFontOfSize:26];
    
    [_scrollView addSubview:name];
    _recentMatch=[[UITableView alloc] initWithFrame:CGRectMake(5, 375, 310, 1000) style:UITableViewStylePlain];
    _recentMatch.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _recentMatch.separatorColor = [UIColor blackColor];
    [_recentMatch setBackgroundColor:[UIColor colorWithRed:9/255.0 green:12/255.0 blue:18/255.0 alpha:1]];
    _recentMatch.separatorInset=UIEdgeInsetsZero;
    _recentMatch.delegate=self;
    _recentMatch.dataSource=self;
    [_scrollView setBackgroundColor:[UIColor colorWithRed:9/255.0 green:12/255.0 blue:18/255.0 alpha:1]];
    [_scrollView addSubview:_recentMatch];
    [_recentMatch setScrollEnabled:NO];
    
    UIView *KDA=[[UIView alloc] initWithFrame:CGRectMake(5, 185, 155, 180)];
    [KDA setBackgroundColor:[UIColor colorWithRed:22/255.0 green:27/255.0 blue:33/255.0 alpha:1]];
    
    UIView *KDAHeader=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 155, 30)];
    KDAHeader.backgroundColor=[UIColor colorWithRed:20/255.0 green:35/255.0 blue:48/255.0 alpha:1];
    
    _KDALabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 40, 155, 30)];
    _KDALabel.textAlignment=NSTextAlignmentCenter;
    _KDALabel.font=[UIFont systemFontOfSize:30];
    _KDALabel.text=@"10.0";
    _KDALabel.textColor=[UIColor colorWithRed:136/255.0 green:187/255.0 blue:225/255.0 alpha:1];
    [KDA addSubview:_KDALabel];
    
    
    _KDALabelTitle=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 155, 30)];
    _KDALabelTitle.font=[UIFont systemFontOfSize:14];
    _KDALabelTitle.text=@"近100场平均KDA";
    _KDALabelTitle.textColor=[UIColor colorWithRed:136/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    
    UIImage *wenhao=[UIImage imageNamed:@"wenhao"];
    UIButton *wen=[[UIButton alloc] initWithFrame:CGRectMake(110, 5, 20, 20)];
    [wen setBackgroundImage:wenhao forState:UIControlStateNormal];
    [wen addTarget:self action:@selector(wenhao) forControlEvents:UIControlEventTouchUpInside];
    
    _KDALabelTitle.userInteractionEnabled=YES;
    [_KDALabelTitle addSubview:wen];
    [KDAHeader addSubview:_KDALabelTitle];
    
    
    _KDADetail=[[UILabel alloc] initWithFrame:CGRectMake(0, 70, 155, 30)];
    _KDADetail.textAlignment=NSTextAlignmentCenter;
    _KDADetail.font=[UIFont systemFontOfSize:16];
    _KDADetail.text=@"10.0/11/11";
    _KDADetail.textColor=[UIColor colorWithRed:77/255.0 green:128/255.0 blue:121/255.0 alpha:1];
    [KDA addSubview:_KDADetail];
    
    
    _wincount=[[UILabel alloc] initWithFrame:CGRectMake(0, 100, 80, 30)];
    _wincount.textAlignment=NSTextAlignmentRight;
    _wincount.font=[UIFont systemFontOfSize:16];
    _wincount.text=@"10.0/";
    _wincount.textColor=[UIColor colorWithRed:68/255.0 green:192/255.0 blue:16/255.0 alpha:1];
    [KDA addSubview:_wincount];
    
    _losecount=[[UILabel alloc] initWithFrame:CGRectMake(80, 100, 80, 30)];
    _losecount.textAlignment=NSTextAlignmentLeft;
    _losecount.font=[UIFont systemFontOfSize:16];
    _losecount.text=@"10.0";
    _losecount.textColor=[UIColor colorWithRed:200/255.0 green:26/255.0 blue:26/255.0 alpha:1];
    [KDA addSubview:_losecount];
    
    _straightPieChart = [[AksStraightPieChart alloc]initWithFrame:CGRectMake(10, 140, 135, 10)];
    [KDA addSubview:_straightPieChart];
    [KDA addSubview:KDAHeader];
    
    
    UIView *ALL=[[UIView alloc] initWithFrame:CGRectMake(165, 185, 150, 180)];
    [ALL setBackgroundColor:[UIColor colorWithRed:22/255.0 green:27/255.0 blue:33/255.0 alpha:1]];
    
    UIView *ALLHeader=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    ALLHeader.backgroundColor=[UIColor colorWithRed:20/255.0 green:35/255.0 blue:48/255.0 alpha:1];
    [ALL addSubview:ALLHeader];
    
    _ALLLabelTitle=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 155, 30)];
    _ALLLabelTitle.font=[UIFont systemFontOfSize:14];
    _ALLLabelTitle.text=@"所有比赛统计";
    _ALLLabelTitle.textColor=[UIColor colorWithRed:136/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    
    [ALLHeader addSubview:_ALLLabelTitle];
    
    _ALLcount=[[UILabel alloc] initWithFrame:CGRectMake(5, 35, 155, 20)];
    _ALLcount.font=[UIFont systemFontOfSize:14];
    _ALLcount.textColor=[UIColor colorWithRed:136/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    [ALL addSubview:_ALLcount];
    
    _ALLwincount=[[UILabel alloc] initWithFrame:CGRectMake(5, 55, 155, 20)];
    _ALLwincount.font=[UIFont systemFontOfSize:14];
    _ALLwincount.textColor=[UIColor colorWithRed:136/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    [ALL addSubview:_ALLwincount];
    
    
    percent=[[PercentageChart alloc] initWithFrame:CGRectMake(5, 100, 140, 80)];
    
    [percent setMainColor:[UIColor greenColor]];
    [percent setSecondaryColor:[UIColor redColor]];
    [percent setLineColor:[UIColor blackColor]];
    [percent setFontSize:10.0];
    [percent setText:@"胜率"];
    [ALL addSubview:percent];
    
    
    [percent setPercentage:20.0];
    [_scrollView addSubview:ALL];
    [_scrollView addSubview:KDA];
}

-(void)wenhao
{
    NSLog(@"fff");
}

-(void)loadTheData:(NSString*)rolename
{
    [self havaRoleName:rolename];
    [self getRecentMatch:rolename];
    [self getRoleData:rolename];
    [self getRole:rolename];
    
}

- (void)getRole:(NSString*)rolename
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain", nil];
    NSDictionary *parameters=[NSDictionary dictionaryWithObjectsAndKeys:rolename,@"name", nil];
    [manager POST:@"http://300report.jumpw.com/api/getrole" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *Result=[responseObject objectForKey:@"Result"];
        if([Result isEqualToString:@"OK"])
        {
            NSDictionary *Role=[responseObject objectForKey:@"Role"];
            float win=[[Role objectForKey:@"WinCount"] floatValue];
            float total=[[Role objectForKey:@"MatchCount"] floatValue];
            [percent setPercentage:win/total*100];
            _ALLwincount.text=[NSString stringWithFormat:@"胜场数:%d",[[Role objectForKey:@"WinCount"] integerValue]];
            _ALLcount.text=[NSString stringWithFormat:@"总场数:%d",[[Role objectForKey:@"MatchCount"] integerValue]];
        }
        else
        {
            NSLog(@"no");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
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


-(void)getRoleData:(NSString*)rolename
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain", nil];
    NSDictionary *paremeters=[NSDictionary dictionaryWithObjectsAndKeys:rolename,@"name", nil];
    [manager GET:@"http://218.244.143.212:2015/getPlayerData" parameters:paremeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *result=[responseObject objectForKey:@"Result"];
        if([result isEqualToString:@"OK"])
        {
            RecentModel *model=[[RecentModel alloc] initWithObject:[responseObject objectForKey:@"PlayerDataList"]];
            recentModel=model;
            _KDALabelTitle.text=[NSString stringWithFormat:@"近%lu场平均KDA",(unsigned long)model.statisticCount];
            
            _KDADetail.text=[NSString stringWithFormat:@"%.1f/%.1f/%.1f",(float)model.kills/model.statisticCount,(float)model.dead/model.statisticCount,(float)model.assist /model.statisticCount];
            _KDALabel.text=[NSString stringWithFormat:@"%.1f",((float)model.kills/model.statisticCount+(float)model.assist /model.statisticCount)/((float)model.dead/model.statisticCount)*3];
            _wincount.text=[NSString stringWithFormat:@"%lu 胜/",(unsigned long)model.winCount];
            _losecount.text=[NSString stringWithFormat:@"%lu 负",(unsigned long)model.loseCount];
            [_straightPieChart clearChart];
            [_straightPieChart addDataToRepresent:(int)model.winCount WithColor:[UIColor colorWithRed:92/255.0 green:192/255.0 blue:11/255.0 alpha:1]];
            [_straightPieChart addDataToRepresent:(int)model.loseCount WithColor:[UIColor colorWithRed:220/255.0 green:25/255.0 blue:1/255.0 alpha:1]];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
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
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return [MatchData count];
    }
    else
        return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 50.0;
    }
    return 50.0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        static NSString *identifer=@"MatchCell";
        MatchTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
        if(cell==nil)
        {
            cell=[[MatchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        MatchModel *model=MatchData[indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell config:model];
        return cell;
    }
    else{
        static NSString *identifer=@"rankhCell";
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        
        UILabel *total=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 20)];
        total.font=[UIFont systemFontOfSize:14];
        UILabel *pj=[[UILabel alloc] initWithFrame:CGRectMake(150, 10, 150, 20)];
        pj.font=[UIFont systemFontOfSize:14];
        RecentModel *model=recentModel;
        if(model!=nil){
            switch (indexPath.row) {
                case 0:
                    total.text=[NSString stringWithFormat:@"总杀人数:%lu",(unsigned long)model.kills];
                    pj.text=[NSString stringWithFormat:@"平均每场杀人:%.2f",(CGFloat)model.kills/(CGFloat)[model getSum]];
                    [cell addSubview:total];
                    [cell addSubview:pj];
                    break;
                case 1:
                    total.text=[NSString stringWithFormat:@"总死亡数:%lu",(unsigned long)model.dead];
                    pj.text=[NSString stringWithFormat:@"平均每场死亡:%.2f",(CGFloat)model.dead/(CGFloat)[model getSum]];
                    [cell addSubview:total];
                    [cell addSubview:pj];
                    break;
                case 2:
                    total.text=[NSString stringWithFormat:@"总助攻数:%lu",(unsigned long)model.assist];
                    pj.text=[NSString stringWithFormat:@"平均每场助攻:%.2f",(CGFloat)model.assist/(CGFloat)[model getSum]];
                    [cell addSubview:total];
                    [cell addSubview:pj];
                    break;
                case 3:
                    total.text=[NSString stringWithFormat:@"总推塔数:%lu",(unsigned long)model.destory];
                    pj.text=[NSString stringWithFormat:@"平均每场推塔:%.2f",(CGFloat)model.destory/(CGFloat)[model getSum]];
                    [cell addSubview:total];
                    [cell addSubview:pj];
                    break;
                case 4:
                    total.text=[NSString stringWithFormat:@"总金钱数:%lu",(unsigned long)model.money];
                    pj.text=[NSString stringWithFormat:@"平均每场金钱:%.2f",(CGFloat)model.money/(CGFloat)[model getSum]];
                    [cell addSubview:total];
                    [cell addSubview:pj];
                    break;
                case 5:
                    total.text=[NSString stringWithFormat:@"最高连胜:%lu",(unsigned long)recentModel.seriesWin];
                    [cell addSubview:total];
                    
                    break;
                case 6:
                    total.text=[NSString stringWithFormat:@"最高连败:%lu",(unsigned long)recentModel.seriesLose];
                    [cell addSubview:total];
                    
                    break;
                    
                default:
                    break;
            }
        }
        
        
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        MatchTableViewCell *cell=(MatchTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        //NSLog(@"%d",cell.MatchID);
        MatchDetailViewController *match=[[MatchDetailViewController alloc] init];
        match.MatchID=cell.MatchID;
        [self.navigationController pushViewController:match animated:YES];
    }
}





@end
