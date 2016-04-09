//
//  MainViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "MainViewController.h"
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
#import "CacheEntence.h"
#import <AVOSCloud/AVOSCloud.h>
#import <UIImageView+WebCache.h>

#define NAME_COLOR                 [UIColor colorWithRed:220/255.0f green:187/255.0f blue:23/255.0f alpha:1]
@interface MainViewController ()<CHScaleHeaderDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    CHHeader *_header;
    NSMutableArray *MatchData;
    RecentModel *recentModel;
    PercentageChart *percent;
    UIBarButtonItem *right;
    NSString *Rolename;
}

@property (nonatomic,strong) NSUserDefaults *userdefault;
@property (nonatomic,strong) AksStraightPieChart * straightPieChart;
@property (nonatomic, assign) BOOL isOTHER;
@end

@implementation MainViewController


- (instancetype)initWithOtherHero:(NSString *)name {
    self = [super init];
    if (self) {
        [self havaRoleName:name];
        _isOTHER=YES;
        Rolename=name;
        self.navigationItem.leftBarButtonItem=nil;
        self.navigationItem.rightBarButtonItem=nil;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    
    //判断来源，是查看他人页面还是自己的战绩，区别为导航栏的不同
    if (_isOTHER == NO) {
        right=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon_bulb"] style:UIBarButtonItemStyleDone target:self action:@selector(search)];
        
        UIBarButtonItem *rightButton = right;
        self.navigationItem.rightBarButtonItem=rightButton;
        self.userdefault=[NSUserDefaults standardUserDefaults];
        
        NSString *rolename=[self.userdefault objectForKey:@"DefaultRole"];
        if(rolename==nil) {
            [self notHaveRoleName];
        } else {
            Rolename=rolename;
            [self havaRoleName:rolename];
        }
    }
 
}

-(void)refresh {
    [self viewDidLoad];
    [_scrollView headerEndRefreshing];
}

-(void)loadSteup {
    _LodingActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    //_LodingActivityIndicator.center = CGPointMake(100.0f, 100.0f);//只能设置中心，不能设置大小
    _LodingActivityIndicator.frame=CGRectMake(0, 0, WIDTH(_KDA), HEIGHT(_KDA));//不建议这样设置，因为UIActivityIndicatorView是不能改变大小只能改变位置，这样设置得到的结果是控件的中心在（100，100）上，而不是和其他控件的frame一样左上角在（100， 100）长为100，宽为100.
    [_KDA addSubview:_LodingActivityIndicator];
    [_LodingActivityIndicator setColor:[UIColor grayColor]];
    [_LodingActivityIndicator startAnimating]; // 开始旋转
    //[testActivityIndicator stopAnimating]; // 结束旋转
    [_LodingActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
}

- (void)havaRoleName:(NSString*)rolename {
    if(_scrollView==nil) {
        CGRect frame = [[UIScreen mainScreen] bounds];
        frame.size.height -= 44;
        _scrollView=[[UIScrollView alloc] initWithFrame:frame];
    }
    [_scrollView setContentSize:CGSizeMake(Main_Screen_Width, 1050)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,Main_Screen_Width , Main_Screen_Width * 180.0/320.0)];
    [imageView setImage:[UIImage imageNamed:@"indexbg"]];
    [_scrollView addSubview:imageView];
    [self.view addSubview:_scrollView];
    __block MainViewController *blockSelf = self;
    [_scrollView addHeaderWithCallback:^{
        [blockSelf refresh];
    }];
    
    if (_name==nil) {
        _name=[[UILabel alloc] initWithFrame:CGRectMake(130, MaxY(imageView)-50, 190, 30)];
    }
    
    _name.text=rolename;
    _name.textAlignment=NSTextAlignmentCenter;
    _name.textColor=NAME_COLOR;
    _name.font=[UIFont boldSystemFontOfSize:26];
    
    UIImageView *combat=[[UIImageView alloc] initWithFrame:CGRectMake(20, MaxY(imageView)-70, 100, 50)];
    combat.image=[UIImage imageNamed:@"combat"];
    
    [_scrollView addSubview:combat];
    
    _combat=[[UILabel alloc] initWithFrame:CGRectMake(20, MaxY(imageView)-50, 100, 30)];
    _combat.textAlignment=NSTextAlignmentCenter;
    _combat.font=[UIFont systemFontOfSize:20];
    _combat.text=@"????";
    [_scrollView addSubview:_combat];
    [_scrollView addSubview:_name];
    
    //ALL
    UIView *ALL=[[UIView alloc] initWithFrame:CGRectMake(0, MaxY(imageView)+5, Main_Screen_Width, 180)];
    [ALL setBackgroundColor:[UIColor colorWithRed:22/255.0 green:27/255.0 blue:33/255.0 alpha:1]];
    
    UIView *ALLHeader=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(ALL), 30)];
    ALLHeader.backgroundColor=[UIColor colorWithRed:20/255.0 green:35/255.0 blue:48/255.0 alpha:1];
    [ALL addSubview:ALLHeader];
    
    _ALLLabelTitle=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, WIDTH(ALL), 30)];
    _ALLLabelTitle.font=[UIFont systemFontOfSize:14];
    _ALLLabelTitle.text=@"所有比赛统计";
    _ALLLabelTitle.textColor=[UIColor colorWithRed:136/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    
    [ALLHeader addSubview:_ALLLabelTitle];
    
    _ALLcount=[[UILabel alloc] initWithFrame:CGRectMake(15, 50, WIDTH(ALL), 20)];
    _ALLcount.font=[UIFont systemFontOfSize:16];
    _ALLcount.textColor=[UIColor colorWithRed:136/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    [ALL addSubview:_ALLcount];
    
    _ALLwincount=[[UILabel alloc] initWithFrame:CGRectMake(15, 75, WIDTH(ALL), 20)];
    _ALLwincount.font=[UIFont systemFontOfSize:16];
    _ALLwincount.textColor=[UIColor colorWithRed:136/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    [ALL addSubview:_ALLwincount];
    
    [self loadSteup];
    percent=[[PercentageChart alloc] initWithFrame:CGRectMake(Main_Screen_Width/2, 60, Main_Screen_Width/2, 100)];
    
    [percent setMainColor:[UIColor greenColor]];
    [percent setSecondaryColor:[UIColor redColor]];
    [percent setLineColor:[UIColor blackColor]];
    [percent setFontSize:10.0];
    [percent setText:@"胜率"];
    [ALL addSubview:percent];
    
    [percent setPercentage:20.0];
    [_scrollView addSubview:ALL];
    
    _recentMatch=[[UITableView alloc] initWithFrame:CGRectMake(5, MaxY(ALL)+5, Main_Screen_Width-10, 1000) style:UITableViewStylePlain];
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

- (void)viewWillAppear:(BOOL)animated {
    [AVAnalytics beginLogPageView:@"main页面"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [AVAnalytics endLogPageView:@"main页面"];
}

-(void)loadTheData:(NSString *) rolename {
    [self getRecentMatch:rolename];
    [self getRole:rolename];
}

- (void)getRole:(NSString*)rolename
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain", nil];
    NSDictionary *parameters=[NSDictionary dictionaryWithObjectsAndKeys:rolename,@"name", nil];
    [manager POST:HERO300_URL(@"getrole") parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *Result=[responseObject objectForKey:@"Result"];
        if([Result isEqualToString:@"OK"])
        {
            NSDictionary *Role=[responseObject objectForKey:@"Role"];
            float win=[[Role objectForKey:@"WinCount"] floatValue];
            float total=[[Role objectForKey:@"MatchCount"] floatValue];
            NSInteger jumoValue = [[Role objectForKey:@"JumpValue"] integerValue];
            _combat.text = [NSString stringWithFormat:@"%ld",(long)jumoValue];
            [percent setPercentage:win/total*100];
            _ALLwincount.text=[NSString stringWithFormat:@"胜场数:%ld",(long)[[Role objectForKey:@"WinCount"] integerValue]];
            _ALLcount.text=[NSString stringWithFormat:@"总场数:%ld",(long)[[Role objectForKey:@"MatchCount"] integerValue]];
        } else {
            
            
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


//拉取最近比赛 ,从300服务器
-(void)getRecentMatch:(NSString*)rolename {
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain", nil];
    NSDictionary *paremeters=[NSDictionary dictionaryWithObjectsAndKeys:rolename,@"name", nil];
    [manager GET:HERO300_URL(@"getlist") parameters:paremeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (void)notHaveRoleName {
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

- (void)addDefault {
    if([_searchName.text length]==0) {
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
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"用户不存在" preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:action];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    }
}

-(void)initButton {
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
//    [button1 addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
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

-(void)clear {
    [self.userdefault setObject:nil forKey:@"DefaultRole"];
    [self search];
    for(UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    [self notHaveRoleName];
}

-(void)pingjia {
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

-(void)save {
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

#pragma mark - UItableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [MatchData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 50.0;
    }
    return 50.0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0){
        MatchTableViewCell *cell=(MatchTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        MatchDetailViewController *match=[[MatchDetailViewController alloc] init];
        match.MatchID=cell.MatchID;
        [self.navigationController pushViewController:match animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  
    UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, Main_Screen_Width, 30)];
    [view setBackgroundColor:BACKGROUND_COLOR];
    [view addTarget:self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
    [view setTitle:@"点击加载更多比赛" forState:UIControlStateNormal];
    [[view titleLabel] setFont:[UIFont systemFontOfSize:14]];
    return view;
}

- (void)loadMore {
    //获取当前表格的场数
    NSUInteger nowCount=[MatchData count];
    
    NSString *url=[NSString stringWithFormat:@"http://300report.jumpw.com/api/getlist"];
    NSDictionary *parameters= [NSDictionary dictionaryWithObjectsAndKeys:Rolename,@"name",[NSString stringWithFormat:@"%ld",(unsigned long)nowCount],@"index", nil];
    [CacheEntence RequestRemoteURL:url paramters:parameters Cache:NO customHeader:@"text/plain" success:^(id responseObject) {
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
            [MatchData addObjectsFromArray:dataTemp];
            [_recentMatch reloadData];
            CGSize contentSize = _scrollView.contentSize;
            contentSize.height = contentSize.height + 50*[dataTemp count];
            _scrollView.contentSize = contentSize;
            CGRect tableFrame = _recentMatch.frame;
            tableFrame.size.height = [MatchData count]*50+30;
            _recentMatch.frame=tableFrame;
            
        }
    } failure:^(NSError *error) {
        NSLog(@"error%@",error);
    }];
    
}




@end
