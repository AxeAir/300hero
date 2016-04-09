//
//  SideMenuTableView.m
//  300勇士盒
//
//  Created by ChenHao on 10/7/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "SideMenuTableView.h"
#import "sigleMenu.h"
#import "UIViewController+CHSideMenu.h"
#import "UConstants.h"
#import <AVOSCloud/AVUser.h>
#import "Login.h"

@interface SideMenuTableView ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITabBarControllerDelegate>
{
     NSArray *itemsArray;
}
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *logoutbutton;
@end

@implementation SideMenuTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    sigleMenu *item1 = [[sigleMenu alloc]initWithTitle:@"我的战绩" image:[UIImage imageNamed:@"myzj"]];
    sigleMenu *item2 = [[sigleMenu alloc]initWithTitle:@"排行榜" image:[UIImage imageNamed:@"rank"]];
//    sigleMenu *item3 = [[sigleMenu alloc]initWithTitle:@"大神榜" image:[UIImage imageNamed:@"god"]];
//    sigleMenu *item4 = [[sigleMenu alloc]initWithTitle:@"最新资讯" image:[UIImage imageNamed:@"news"]];
    //sigleMenu *item4 = [[sigleMenu alloc]initWithTitle:@"工具" image:[UIImage imageNamed:@"icon2.png"]];
//    sigleMenu *item5 = [[sigleMenu alloc]initWithTitle:@"英雄" image:[UIImage imageNamed:@"fire"]];
    sigleMenu *item6 = [[sigleMenu alloc]initWithTitle:@"关于我们" image:[UIImage imageNamed:@"mail"]];
    
    NSArray *arr=[[NSArray alloc] initWithObjects:item1,item2,item6, nil];
    itemsArray=arr;
    
    
    _table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, Main_Screen_Height) style:UITableViewStyleGrouped];
    _table.delegate=self;
    _table.dataSource=self;
    _table.backgroundColor=[UIColor whiteColor];
    _table.scrollEnabled=NO;
    [self.view addSubview:_table];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 220;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [itemsArray count];
}

#define MAIN_VIEW_TAG 1
#define TITLE_LABLE_TAG 2
#define IMAGE_VIEW_TAG 3

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UILabel *titleLabel;
    UIImageView *imageView;
    static NSString *cellid=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
   

    sigleMenu *item = [itemsArray objectAtIndex:indexPath.row];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.backgroundColor = [UIColor whiteColor];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 15, 80, 20)];
        titleLabel.tag = TITLE_LABLE_TAG;
        titleLabel.textColor = [UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:1];;
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        
        [cell.contentView addSubview:titleLabel];
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 30, 30)];
        imageView.tag = IMAGE_VIEW_TAG;
        [cell.contentView addSubview:imageView];
    }else {
        titleLabel = (UILabel *)[cell.contentView viewWithTag:TITLE_LABLE_TAG];
        imageView = (UIImageView *)[cell.contentView viewWithTag:IMAGE_VIEW_TAG];
    }
    //[ce setBackgroundColor:[UIColor colorWithRed:9/255.0 green:12/255.0 blue:18/255.0 alpha:1]];
    titleLabel.text = item.title;
    imageView.image = item.imageView.image;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            if([[self.sideMenuController getContent] isKindOfClass:[MainNavgationController class]]) {
                [self.sideMenuController toggleMenu:YES];
            } else {
                _main=[[MainViewController alloc] init];
                _mainNav=[[MainNavgationController alloc] initWithRootViewController:_main];
                [self.sideMenuController setContentController:_mainNav animted:YES];
            }
            break;
        case 1:
            if([[self.sideMenuController getContent] isKindOfClass:[RankNavController class]]) {
                [self.sideMenuController toggleMenu:YES];
            } else {
                _rankTable=[[RankTypeTableViewController alloc] initWithStyle:UITableViewStylePlain];
                _rankNav=[[RankNavController alloc] initWithRootViewController:_rankTable];
                [self.sideMenuController setContentController:_rankNav animted:YES];
            }
            break;
//        case 2:
//            if([[self.sideMenuController getContent] isKindOfClass:[LXNavViewController class]])
//            {
//                [self.sideMenuController toggleMenu:YES];
//            }
//            else
//            {
//                _lxTable=[[LXTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
//                _lxNav=[[LXNavViewController alloc] initWithRootViewController:_lxTable];
//                [self.sideMenuController setContentController:_lxNav animted:YES];
//            }
//            break;
//            
//        case 3:
//            if([[self.sideMenuController getContent] isKindOfClass:[SettingNavViewController class]])
//            {
//                [self.sideMenuController toggleMenu:YES];
//            }
//            else
//            {
//                _news=[[NewsViewController alloc] init];
//                _newsnav=[[NewsNavViewController alloc] initWithRootViewController:_news];
//                [self.sideMenuController setContentController:_newsnav animted:YES];
//            }
//            break;
//        case 4:
//        {
//            if([[self.sideMenuController getContent] isKindOfClass:[HeroViewController class]])
//            {
//                [self.sideMenuController toggleMenu:YES];
//            }
//            else
//            {
//                _hero=[[HeroCollectionViewController alloc] init];
//                _heroNav=[[HeroNavViewController alloc] initWithRootViewController:_hero];
//                [self.sideMenuController setContentController:_heroNav animted:YES];
//            }
//            
//        }
//            break;
        case 2:
            if([[self.sideMenuController getContent] isKindOfClass:[AboutNavViewController class]])
            {
                [self.sideMenuController toggleMenu:YES];
            }
            else
            {
                _about=[[AbountViewController alloc] init];
                _aboutNav=[[AboutNavViewController alloc] initWithRootViewController:_about];
                [self.sideMenuController setContentController:_aboutNav animted:YES];
            }
            break;
        
            
        default:
            break;
    }
    
    
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  if(section==0) {
      UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 220)];
      view.backgroundColor=[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:1];
      
      UISearchBar *searchbar=[[UISearchBar alloc] initWithFrame:CGRectMake(10, 10, 180, 60)];
      searchbar.delegate=self;
      searchbar.backgroundImage=[UIImage imageNamed:@"background.png"];
//      [view addSubview:searchbar];
      
      
      _headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1024"]];
      [_headerView setFrame:CGRectMake(60, MaxY(searchbar)+10, 80, 80)];
      [[_headerView layer] setCornerRadius:40.0];
      [[_headerView layer] setMasksToBounds:YES];
      [[_headerView layer] setBorderColor:[UIColor whiteColor].CGColor];
      [[_headerView layer] setBorderWidth:1.0];
//      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeader)];
//      [_headerView setUserInteractionEnabled:YES];
//      [_headerView addGestureRecognizer:tap];
      [view addSubview:_headerView];
      
      AVUser * currentUser = [AVUser currentUser];
      
      if (currentUser != nil) {
          // 允许用户使用应用
           _nameLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY(_headerView), self.view.frame.size.width, 30)];
          _nameLabel.text=[currentUser objectForKey:@"NickName"];
          NSString *avatarID=[currentUser objectForKey:@"AvatarID"];
        
          [_headerView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",avatarID]]];
          [_nameLabel setTextAlignment:NSTextAlignmentCenter];
          [_nameLabel setTextColor:[UIColor whiteColor]];
          [self.view addSubview:_nameLabel];
          
          
          _logoutbutton=[[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, MaxY(_nameLabel), 100, 20)];
          [_logoutbutton setTitle:@"退出登录" forState:UIControlStateNormal];
          [[_logoutbutton titleLabel] setFont:[UIFont systemFontOfSize:14]];
          [_logoutbutton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
          [self.view addSubview:_logoutbutton];
      } else {
          //缓存用户对象为空时， 可打开用户注册界面…
          
          
      }
      
      return view;
  }
    return nil;
}


- (void)logout {
    [AVUser logOut];
}


- (void)clickHeader
{
    AVUser * currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        // 允许用户使用应用
    } else {
        //缓存用户对象为空时， 可打开用户注册界面…
        [self.sideMenuController hideMenuAnimated:YES];
         Login *login = [[Login alloc] init];
        //_registerNav = [[RegisterLoginNavViewController alloc] initWithRootViewController:_registerCV];
//        [self addChildViewController:lo]
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        
        [self presentViewController:nav animated:YES completion:nil];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(handleColorChange:)
               name:@"do"
             object:nil];
    [self viewDidLoad];
    
}

-(void)handleColorChange:(NSNotification*)sender{
    
    NSDictionary *dic=(NSDictionary*)sender.userInfo;
    
    _other=[[MainViewController alloc] initWithOtherHero:[dic objectForKey:@"name"]];
    _mainNav=[[MainNavgationController alloc] initWithRootViewController:_other];
    [self.sideMenuController setContentController:_mainNav animted:YES];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    _search=[[SearchViewController alloc] init];
    [self presentViewController:_search animated:YES completion:^{
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
