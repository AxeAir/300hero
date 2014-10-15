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
#import "SecondViewController.h"


@interface SideMenuTableView ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITabBarControllerDelegate>
{
     NSArray *itemsArray;
}

@end

@implementation SideMenuTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sigleMenu *item1 = [[sigleMenu alloc]initWithTitle:@"我的战绩" image:[UIImage imageNamed:@"icon1.png"]];
    sigleMenu *item2 = [[sigleMenu alloc]initWithTitle:@"排行榜" image:[UIImage imageNamed:@"icon2.png"]];
    sigleMenu *item3 = [[sigleMenu alloc]initWithTitle:@"工具" image:[UIImage imageNamed:@"icon2.png"]];
    sigleMenu *item4 = [[sigleMenu alloc]initWithTitle:@"福利" image:[UIImage imageNamed:@"icon2.png"]];
    
    NSArray *arr=[[NSArray alloc] initWithObjects:item1,item2,item3,item4, nil];
    itemsArray=arr;
    
    
    _table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, 600)];
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
    return 64;
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
    
    UIView *circleView;
    UILabel *titleLabel;
    UIImageView *imageView;
    static NSString *cellid=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    
    
    sigleMenu *item = [itemsArray objectAtIndex:indexPath.row];
    //NSLog(@"%@",item);
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.backgroundColor = [UIColor whiteColor];
        
        circleView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 55, 55)];
        circleView.tag = MAIN_VIEW_TAG;
        circleView.backgroundColor = [UIColor clearColor];
        circleView.layer.borderWidth = 0.5;
        circleView.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.7].CGColor;
        circleView.layer.cornerRadius = circleView.bounds.size.height/2;
        circleView.clipsToBounds = YES;
        
        [cell.contentView addSubview:circleView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 10.0, 120, 60)];
        titleLabel.tag = TITLE_LABLE_TAG;
        titleLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1];
        titleLabel.font = [UIFont fontWithName:@"Avenir Next" size:16];
        
        [cell.contentView addSubview:titleLabel];
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
        imageView.tag = IMAGE_VIEW_TAG;
        imageView.center = circleView.center;
        [cell.contentView addSubview:imageView];
    }else {
        
        circleView = (UIView *)[cell.contentView viewWithTag:MAIN_VIEW_TAG];
        titleLabel = (UILabel *)[cell.contentView viewWithTag:TITLE_LABLE_TAG];
        imageView = (UIImageView *)[cell.contentView viewWithTag:IMAGE_VIEW_TAG];
    }
    
    titleLabel.text = item.title;
    imageView.image = item.imageView.image;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            _main=[[MainViewController alloc] init];
            _mainNav=[[MainNavgationController alloc] initWithRootViewController:_main];
            [self.sideMenuController setContentController:_mainNav animted:YES];
            
            break;
        case 1:
            _rankTable=[[RankTypeTableViewController alloc] initWithStyle:UITableViewStylePlain];
            _rankNav=[[RankNavController alloc] initWithRootViewController:_rankTable];
            [self.sideMenuController setContentController:_rankNav animted:YES];
            
            break;
        case 2:
            _toolTable=[[ToolTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            _toolNav=[[ToolNavgationController alloc] initWithRootViewController:_toolTable];
            [self.sideMenuController setContentController:_toolNav animted:YES];
            
            break;
            
        default:
            break;
    }
    
    
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  if(section==0)
  {
      UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
      view.backgroundColor=[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:1];
      
      UISearchBar *searchbar=[[UISearchBar alloc] initWithFrame:CGRectMake(10, 10, 180, 60)];
      searchbar.delegate=self;
      searchbar.backgroundImage=[UIImage imageNamed:@"background.png"];
      [view addSubview:searchbar];
      return view;
  }
    return nil;
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _search=[[SearchViewController alloc] init];
    [self presentViewController:_search animated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}




@end
