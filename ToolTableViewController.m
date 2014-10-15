//
//  ToolTableViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "ToolTableViewController.h"
#import "UIViewController+CHSideMenu.h"
@interface ToolTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ToolTableViewController

- (void)viewDidLoad {
    
    self.title=@"工具箱";
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1] forKey:NSForegroundColorAttributeName];
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"burger"] style:UIBarButtonItemStyleDone target:self action:@selector(toogleMenu)];
    self.navigationItem.leftBarButtonItem=left;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section==0)
    {
        return 5;
    }
    if(section==1)
    {
        return 2;
    }
    if(section==3)
    {
        return 1;
    }
    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    static NSString *Identifier=@"ToolcellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    
    // Configure the cell...
    switch (indexPath.section) {
        case 0:
            if(indexPath.row==0)
            {
                cell.textLabel.text=@"英雄";
            }
            if(indexPath.row==1)
            {
                cell.textLabel.text=@"装备";
            }
            if(indexPath.row==2)
            {
                cell.textLabel.text=@"游戏百科";
            }
            if(indexPath.row==3)
            {
                cell.textLabel.text=@"视频";
            }
            if(indexPath.row==4)
            {
                cell.textLabel.text=@"论坛";
            }
            break;
        case 1:
            if(indexPath.row==0)
            {
                cell.textLabel.text=@"设置";
            }
            if(indexPath.row==1)
            {
                cell.textLabel.text=@"反馈";
            }
            break;
        case 2:
            cell.textLabel.text=@"";
            
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if(indexPath.row==0)
            {
                _hero=[[HeroViewController alloc] init];
                [self.navigationController pushViewController:_hero animated:YES];
                //_setting=[[SettingTableViewController alloc] init];
                //[self.navigationController pushViewController:_setting animated:YES];
            }
            break;
        case 1:
            if(indexPath.row==0)
            {
                _setting=[[SettingTableViewController alloc] init];
                [self.navigationController pushViewController:_setting animated:YES];
            }
            break;
            
        default:
            break;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}



@end
