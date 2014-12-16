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
#import "MJRefresh.h"
#import "RecentModel.h"
#import "AksStraightPieChart.h"
#import "PercentageChart.h"
#import "UConstants.h"
#import "Combat.h"

#define NAME_COLOR                 [UIColor colorWithRed:220/255.0f green:187/255.0f blue:23/255.0f alpha:1]
@interface MainViewController ()<CHScaleHeaderDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    CHHeader *_header;
    NSArray *MatchData;
    RecentModel *recentModel;
    PercentageChart *percent;
    UIBarButtonItem *right;
    
}

@property (nonatomic,strong) NSUserDefaults *userdefault;
@property (nonatomic,strong) AksStraightPieChart * straightPieChart;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1] forKey:NSForegroundColorAttributeName];
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"burger"] style:UIBarButtonItemStyleDone target:self action:@selector(toogleMenu)];
    self.navigationItem.leftBarButtonItem=left;
    right=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon_bulb"] style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    
    UIBarButtonItem *rightButton=right;
    self.navigationItem.rightBarButtonItem=rightButton;
    
    self.navigationItem.titleView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    
    self.userdefault=[NSUserDefaults standardUserDefaults];
    
    NSString *rolename=[self.userdefault objectForKey:@"DefaultRole"];
    if(rolename==nil)
    {
        [self notHaveRoleName];
        
    }
    else
    {
        [self havaRoleName:rolename];
    }
    
}

-(void)refresh
{
    [self viewDidLoad];
    [_scrollView headerEndRefreshing];
}


-(void)loadSteup
{
    _LodingActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    //_LodingActivityIndicator.center = CGPointMake(100.0f, 100.0f);//只能设置中心，不能设置大小
    _LodingActivityIndicator.frame=CGRectMake(0, 0, WIDTH(_KDA), HEIGHT(_KDA));//不建议这样设置，因为UIActivityIndicatorView是不能改变大小只能改变位置，这样设置得到的结果是控件的中心在（100，100）上，而不是和其他控件的frame一样左上角在（100， 100）长为100，宽为100.
    [_KDA addSubview:_LodingActivityIndicator];
    [_LodingActivityIndicator setColor:[UIColor grayColor]];
    [_LodingActivityIndicator startAnimating]; // 开始旋转
    //[testActivityIndicator stopAnimating]; // 结束旋转
    [_LodingActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
}

- (void)havaRoleName:(NSString*)rolename
{
    if(_scrollView==nil){
        _scrollView=[[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    [_scrollView setContentSize:CGSizeMake(Main_Screen_Width, 950)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,Main_Screen_Width , Main_Screen_Width*180.0/320.0)];
    [imageView setImage:[UIImage imageNamed:@"indexbg"]];
    [_scrollView addSubview:imageView];
    [self.view addSubview:_scrollView];
    __block MainViewController *blockSelf = self;
    [_scrollView addHeaderWithCallback:^{
        [blockSelf refresh];
    }];
    
    UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(130, MaxY(imageView)-50, 190, 30)];
    name.text=rolename;
    name.textAlignment=NSTextAlignmentCenter;
    name.textColor=NAME_COLOR;
    name.font=[UIFont boldSystemFontOfSize:26];
    
    
    
    UIImageView *combat=[[UIImageView alloc] initWithFrame:CGRectMake(20, MaxY(imageView)-70, 100, 50)];
    combat.image=[UIImage imageNamed:@"combat"];
    
    [_scrollView addSubview:combat];
    
    _combat=[[UILabel alloc] initWithFrame:CGRectMake(20, MaxY(imageView)-50, 100, 30)];
    _combat.textAlignment=NSTextAlignmentCenter;
    _combat.font=[UIFont systemFontOfSize:20];
    _combat.text=@"????";
    [_scrollView addSubview:_combat];
    
    [_scrollView addSubview:name];
    
    
    ///KDA
    
    _KDA=[[UIView alloc] initWithFrame:CGRectMake(5, MaxY(imageView)+5 , (Main_Screen_Width-15)/2, 180)];
    [_KDA setBackgroundColor:[UIColor colorWithRed:22/255.0 green:27/255.0 blue:33/255.0 alpha:1]];
    
    UIView *KDAHeader=[[UIView alloc] initWithFrame:CGRectMake(0, 0,WIDTH(_KDA) , 30)];
    KDAHeader.backgroundColor=[UIColor colorWithRed:20/255.0 green:35/255.0 blue:48/255.0 alpha:1];
    
    _KDALabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 40, WIDTH(_KDA), 30)];
    _KDALabel.textAlignment=NSTextAlignmentCenter;
    _KDALabel.font=[UIFont systemFontOfSize:30];
    _KDALabel.text=@"10.0";
    _KDALabel.textColor=[UIColor colorWithRed:136/255.0 green:187/255.0 blue:225/255.0 alpha:1];
    [_KDA addSubview:_KDALabel];
    
    
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
    [_KDA addSubview:_KDADetail];
    
    
    _wincount=[[UILabel alloc] initWithFrame:CGRectMake(0, 100, 80, 30)];
    _wincount.textAlignment=NSTextAlignmentRight;
    _wincount.font=[UIFont systemFontOfSize:16];
    _wincount.text=@"10.0/";
    _wincount.textColor=[UIColor colorWithRed:68/255.0 green:192/255.0 blue:16/255.0 alpha:1];
    [_KDA addSubview:_wincount];
    
    _losecount=[[UILabel alloc] initWithFrame:CGRectMake(80, 100, 80, 30)];
    _losecount.textAlignment=NSTextAlignmentLeft;
    _losecount.font=[UIFont systemFontOfSize:16];
    _losecount.text=@"10.0";
    _losecount.textColor=[UIColor colorWithRed:200/255.0 green:26/255.0 blue:26/255.0 alpha:1];
    [_KDA addSubview:_losecount];
    
    _straightPieChart = [[AksStraightPieChart alloc]initWithFrame:CGRectMake(10, 140, 135, 10)];
    [_KDA addSubview:_straightPieChart];
    [_KDA addSubview:KDAHeader];
    
    _KDALabel.hidden=YES;
    _losecount.hidden=YES;
    _wincount.hidden=YES;
    _KDADetail.hidden=YES;
    _KDALabel.hidden=YES;
    _straightPieChart.hidden=YES;
    
    //ALL
    UIView *ALL=[[UIView alloc] initWithFrame:CGRectMake(MaxX(_KDA)+5, MaxY(imageView)+5, (Main_Screen_Width-15)/2, 180)];
    [ALL setBackgroundColor:[UIColor colorWithRed:22/255.0 green:27/255.0 blue:33/255.0 alpha:1]];
    
    UIView *ALLHeader=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(ALL), 30)];
    ALLHeader.backgroundColor=[UIColor colorWithRed:20/255.0 green:35/255.0 blue:48/255.0 alpha:1];
    [ALL addSubview:ALLHeader];
    
    _ALLLabelTitle=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, WIDTH(ALL), 30)];
    _ALLLabelTitle.font=[UIFont systemFontOfSize:14];
    _ALLLabelTitle.text=@"所有比赛统计";
    _ALLLabelTitle.textColor=[UIColor colorWithRed:136/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    
    [ALLHeader addSubview:_ALLLabelTitle];
    
    _ALLcount=[[UILabel alloc] initWithFrame:CGRectMake(5, 35, WIDTH(ALL), 20)];
    _ALLcount.font=[UIFont systemFontOfSize:14];
    _ALLcount.textColor=[UIColor colorWithRed:136/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    [ALL addSubview:_ALLcount];
    
    _ALLwincount=[[UILabel alloc] initWithFrame:CGRectMake(5, 55, WIDTH(ALL), 20)];
    _ALLwincount.font=[UIFont systemFontOfSize:14];
    _ALLwincount.textColor=[UIColor colorWithRed:136/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    [ALL addSubview:_ALLwincount];
    
    [self loadSteup];
    percent=[[PercentageChart alloc] initWithFrame:CGRectMake(5, 100, 140, 80)];
    
    [percent setMainColor:[UIColor greenColor]];
    [percent setSecondaryColor:[UIColor redColor]];
    [percent setLineColor:[UIColor blackColor]];
    [percent setFontSize:10.0];
    [percent setText:@"胜率"];
    [ALL addSubview:percent];
    
    
    [percent setPercentage:20.0];
    [_scrollView addSubview:ALL];
    [_scrollView addSubview:_KDA];
    
    
    _recentMatch=[[UITableView alloc] initWithFrame:CGRectMake(5, MaxY(_KDA)+5, Main_Screen_Width-10, 1000) style:UITableViewStylePlain];
    _recentMatch.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _recentMatch.separatorColor = [UIColor blackColor];
    [_recentMatch setBackgroundColor:[UIColor colorWithRed:9/255.0 green:12/255.0 blue:18/255.0 alpha:1]];
    _recentMatch.separatorInset=UIEdgeInsetsZero;
    _recentMatch.delegate=self;
    _recentMatch.dataSource=self;
    [_scrollView setBackgroundColor:[UIColor colorWithRed:9/255.0 green:12/255.0 blue:18/255.0 alpha:1]];
    [_scrollView addSubview:_recentMatch];
    [_recentMatch setScrollEnabled:NO];
    
    
    [self initButton];
    [self loadTheData:rolename];
}

-(void)wenhao
{
    NSLog(@"fff");
}

-(void)loadTheData:(NSString*)rolename
{
    //[self getRoleData:rolename];
    [self getRecentMatch:rolename];
    [self getRole:rolename];
    
}

- (void)getRole:(NSString*)rolename
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain", nil];
    NSDictionary *parameters=[NSDictionary dictionaryWithObjectsAndKeys:rolename,@"name", nil];
    [manager POST:HERO300_URL(@"getrole") parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",responseObject);
        NSString *Result=[responseObject objectForKey:@"Result"];
        if([Result isEqualToString:@"OK"])
        {
            NSDictionary *Role=[responseObject objectForKey:@"Role"];
            float win=[[Role objectForKey:@"WinCount"] floatValue];
            float total=[[Role objectForKey:@"MatchCount"] floatValue];
            [percent setPercentage:win/total*100];
            _ALLwincount.text=[NSString stringWithFormat:@"胜场数:%ld",(long)[[Role objectForKey:@"WinCount"] integerValue]];
            _ALLcount.text=[NSString stringWithFormat:@"总场数:%ld",(long)[[Role objectForKey:@"MatchCount"] integerValue]];
            
            //_combat.text=[Combat getCombat:[[Role objectForKey:@"WinCount"] integerValue] all:[[Role objectForKey:@"MatchCount"] integerValue]];
            
            
             [self updateCount:(int)total rolename:rolename wincout:(int)win];
            [self getRoleData:rolename];
        }
        else
        {
            NSLog(@"no");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


-(void)updateCount:(NSInteger)recentcount  rolename:(NSString*)rolename wincout:(NSInteger)wincount
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    NSDictionary *parameters=[NSDictionary dictionaryWithObjectsAndKeys:rolename,@"name",[NSString stringWithFormat:@"%ld",(long)recentcount],@"matchCount",[NSString stringWithFormat:@"%ld",(long)wincount],@"winCount", nil];
    [manager GET:@"http://218.244.143.212:8520/update/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *Result=[responseObject objectForKey:@"Result"];
        if([Result isEqualToString:@"OK"])
        {
            NSLog(@"拉取更新成功");
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
    [manager GET:HERO300_URL(@"getlist") parameters:paremeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",responseObject);
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



//拉取KDA
-(void)getRoleData:(NSString*)rolename
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    NSDictionary *paremeters=[NSDictionary dictionaryWithObjectsAndKeys:rolename,@"name", nil];
    //NSLog(@"%@",[NSString stringWithFormat:@"http://192.168.1.104:8000/getPlayerData/%@",rolename]);
    
    [manager GET:@"http://218.244.143.212:8520/getPlayerData/" parameters:paremeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_LodingActivityIndicator stopAnimating];
        NSString *result=[responseObject objectForKey:@"Result"];
        
        NSLog(@"%@",responseObject);
        if([result isEqualToString:@"OK"])
        {
            RecentModel *model=[[RecentModel alloc] initWithObject:[responseObject objectForKey:@"List"]];
            recentModel=model;
            _KDALabelTitle.text=[NSString stringWithFormat:@"近%lu场平均KDA",(unsigned long)model.statisticCount];
            
            _KDADetail.text=[NSString stringWithFormat:@"%.1f/%.1f/%.1f",(float)model.kills/model.statisticCount,(float)model.dead/model.statisticCount,(float)model.assist /model.statisticCount];
            
            NSString *kda=[NSString stringWithFormat:@"%.1f",((float)model.kills/model.statisticCount+(float)model.assist/model.statisticCount)/((float)model.dead/model.statisticCount)*3];
            if([kda isEqualToString:@"inf"])
            {
                kda=@"0";
            }
            _KDALabel.text=kda;
            _combat.text=[NSString stringWithFormat:@"%lu",(unsigned long)model.combat];
            
            _wincount.text=[NSString stringWithFormat:@"%lu 胜/",(unsigned long)model.winCount];
            _losecount.text=[NSString stringWithFormat:@"%lu 负",(unsigned long)model.loseCount];
            [_straightPieChart clearChart];
            [_straightPieChart addDataToRepresent:(int)model.winCount WithColor:[UIColor greenColor]];
            [_straightPieChart addDataToRepresent:(int)model.loseCount WithColor:[UIColor colorWithRed:220/255.0 green:25/255.0 blue:1/255.0 alpha:1]];
            
            
            _KDALabel.hidden=NO;
            _losecount.hidden=NO;
            _wincount.hidden=NO;
            _KDADetail.hidden=NO;
            _KDALabel.hidden=NO;
            _straightPieChart.hidden=NO;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_LodingActivityIndicator stopAnimating];
    }];
}


- (void)notHaveRoleName
{
    self.view.backgroundColor=[UIColor whiteColor];
    UIView *bg=[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    
    UILabel *laber=[[UILabel alloc] initWithFrame:CGRectMake(30, 30, Main_Screen_Width-60, 30)];
    laber.text=@"尚未添加默认角色,请添加";
    laber.textAlignment=NSTextAlignmentCenter;
    [bg addSubview:laber];
    
    _searchName=[[UITextField alloc] initWithFrame:CGRectMake(10, 70, Main_Screen_Width-20, 40)];
    _searchName.layer.borderColor = [UIColor grayColor].CGColor;
    
    _searchName.layer.borderWidth =1.0;
    _searchName.layer.cornerRadius =5.0;
    _searchName.delegate=self;
    [bg addSubview:_searchName];
    
    UIButton *searchButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [searchButton setFrame:CGRectMake(10, 120, Main_Screen_Width-20, 40)];
    searchButton.backgroundColor=[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:1];
    [searchButton setTitle:@"添加" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(addDefault) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:searchButton];
    
    [self.view addSubview:bg];
    [self initButton];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
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
        [manager POST:HERO300_URL(@"getrole") parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            NSString *Result=[responseObject objectForKey:@"Result"];
            if([Result isEqualToString:@"OK"])
            {
                NSDictionary *Role=[responseObject objectForKey:@"Role"];
                NSString *RoleName=[Role objectForKey:@"RoleName"];
                [self.userdefault setObject:RoleName forKey:@"DefaultRole"];
                for(UIView *view in [self.view subviews])
                {
                    [view removeFromSuperview];
                }
                [self havaRoleName:RoleName];
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

-(void)initButton
{
    
    _mask=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    
    [_mask setBackgroundColor:[UIColor blackColor]];
    _mask.alpha=0.8;
    UIGestureRecognizer *ges=[[UIGestureRecognizer alloc] init];
    ges.delegate=self;
    
    [_mask addGestureRecognizer:ges];
    [self.view insertSubview:_mask atIndex:99];
    [_mask setHidden:YES];
    
    
    _buttonGroup=[[UIView alloc] initWithFrame:CGRectMake(0, -64, Main_Screen_Width, 80)];
    
    _buttonGroup.backgroundColor=BACKGROUND_COLOR;
    UIButton *button1=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width/4, 80)];
    [button1 setBackgroundImage:[UIImage imageNamed:@"logo"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [_buttonGroup addSubview:button1];
    
    
    
    
    
    
    
    
    
    
   
    UIButton *button2=[[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width/4*1, 0, Main_Screen_Width/4, 80)];
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(0, 55, Main_Screen_Width/4, 20)];
    [button2 addTarget:self action:@selector(pingjia) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *pingjia=[UIImage imageNamed:@"pingjia"];
    UIImageView *pingjiaView=[[UIImageView alloc] initWithFrame:CGRectMake(25, 10, 30, 30)];
    pingjiaView.image=pingjia;
    [button2 addSubview:pingjiaView];
    
    label2.text=@"评价我们";
    label2.font=[UIFont systemFontOfSize:12];
    label2.textAlignment=NSTextAlignmentCenter;
    label2.textColor=[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1];
    [button2 addSubview:label2];
    [_buttonGroup addSubview:button2];
    
    UIButton *button3=[[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width/4*2, 0, Main_Screen_Width/4, 80)];
    UILabel *label3=[[UILabel alloc] initWithFrame:CGRectMake(0, 55, Main_Screen_Width/4, 20)];
    label3.text=@"保存到相册";
    label3.font=[UIFont systemFontOfSize:12];
    label3.textAlignment=NSTextAlignmentCenter;
    label3.textColor=[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1];
    
    UIImage *saveto=[UIImage imageNamed:@"savetophoto"];
    UIImageView *savetoView=[[UIImageView alloc] initWithFrame:CGRectMake(25, 10, 30, 30)];
    savetoView.image=saveto;
    
    [button3 addSubview:savetoView];
    [button3 addSubview:label3];
    [button3 addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];

    [_buttonGroup addSubview:button3];
    
    
    UIButton *button4=[[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width/4*3, 0, Main_Screen_Width/4, 80)];
    
    UILabel *label4=[[UILabel alloc] initWithFrame:CGRectMake(0, 55, Main_Screen_Width/4, 20)];
    label4.text=@"更换默认角色";
    label4.font=[UIFont systemFontOfSize:12];
    label4.textAlignment=NSTextAlignmentCenter;
    label4.textColor=[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1];
    
    UIImage *def=[UIImage imageNamed:@"default"];
    UIImageView *defView=[[UIImageView alloc] initWithFrame:CGRectMake(25, 10, 30, 30)];
    defView.image=def;
    [button4 addSubview:defView];
    [button4 addSubview:label4];
    [button4 addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonGroup addSubview:button4];
    
    _buttonGroup.hidden=YES;
    [self.view insertSubview:_buttonGroup atIndex:100];
    
    
}

-(void)clear
{
    [self.userdefault setObject:nil forKey:@"DefaultRole"];
    [self search];
    for(UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    [self notHaveRoleName];
}

-(void)pingjia
{
    [self search];
    NSString * appstoreUrlString = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?mt=8&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software&id=924796566";
    
    NSURL * url = [NSURL URLWithString:appstoreUrlString];
    
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        NSLog(@"can not open");
    }
    
    NSLog(@"评价");
}



-(void)share
{
//    [self search];
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
//    
//    //构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
//                                       defaultContent:@"默认分享内容，没内容时显示"
//                                                image:[ShareSDK imageWithPath:imagePath]
//                                                title:@"ShareSDK"
//                                                  url:@"http://www.sharesdk.cn"
//                                          description:@"这是一条测试信息"
//                                            mediaType:SSPublishContentMediaTypeNews];
//    
//    [ShareSDK showShareActionSheet:nil
//                         shareList:nil
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:nil
//                      shareOptions: nil
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                if (state == SSResponseStateSuccess)
//                                {
//                                    NSLog(@"分享成功");
//                                }
//                                else if (state == SSResponseStateFail)
//                                {
//                                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
//                                }
//                            }];
    
    
}


-(void)save
{
    UIGraphicsBeginImageContext(CGSizeMake(Main_Screen_Width, MaxY(_KDA)));     //currentView 当前的view
    [self.scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
}


#pragma mark - savePhotoAlbumDelegate
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo {
    NSString *message;
    NSString *title;
    
    //[_activityIndicatorView stopAnimating];
    if (!error) {
        title = @"恭喜";
        message = @"成功保存到相册";
    } else {
        title = @"失败";
        message = [error description];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}


-(void)search
{
    NSLog(@"dd");
    if(_buttonGroup.hidden==YES)
    {
        _buttonGroup.hidden=NO;
        _mask.hidden=NO;
        [UIView animateWithDuration:0.35f
                              delay:0
                            options:(UIViewAnimationOptionAllowUserInteraction|
                                     UIViewAnimationOptionBeginFromCurrentState)
                         animations:^(void) {
                             
                             _buttonGroup.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0,64);
                             
                             //_buttonGroup.alpha = 1;
                             //[navRightButton setTransform:navRound];
                             //[right setTransform:navRound];
                             [right setImage:[UIImage imageNamed:@"menu_icon_bulb_up"]];
                             
                         }
                         completion:^(BOOL finished) {
                         }];
    }
    else
    {
        [UIView animateWithDuration:0.35f
                              delay:0
                            options:(UIViewAnimationOptionAllowUserInteraction|
                                     UIViewAnimationOptionBeginFromCurrentState)
                         animations:^(void) {
                             
                             _buttonGroup.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0,-45);
                             [right setImage:[UIImage imageNamed:@"menu_icon_bulb"]];
                             
                         }
                         completion:^(BOOL finished) {
                             _mask.hidden=YES;
                             _buttonGroup.hidden=YES;
                         }];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    [UIView animateWithDuration:0.35f
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction|
                                 UIViewAnimationOptionBeginFromCurrentState)
                     animations:^(void) {
                         
                         _buttonGroup.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0,-45);
                         [right setImage:[UIImage imageNamed:@"menu_icon_bulb"]];
                         
                     }
                     completion:^(BOOL finished) {
                         _mask.hidden=YES;
                         _buttonGroup.hidden=YES;
                     }];
    
    return  YES;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        MatchTableViewCell *cell=(MatchTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        MatchDetailViewController *match=[[MatchDetailViewController alloc] init];
        match.MatchID=cell.MatchID;
        [self.navigationController pushViewController:match animated:YES];
    }
}




@end
