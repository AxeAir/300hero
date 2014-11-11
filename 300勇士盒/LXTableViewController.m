//
//  LXTableViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/21/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "LXTableViewController.h"
#import "UConstants.h"
#import "UIViewController+CHSideMenu.h"
@interface LXTableViewController ()

@end

@implementation LXTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"大神榜";
    [self.view  setBackgroundColor:BACKGROUND_COLOR];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor blackColor];
    self.tableView.separatorInset=UIEdgeInsetsZero;
    
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1] forKey:NSForegroundColorAttributeName];
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"burger"] style:UIBarButtonItemStyleDone target:self action:@selector(toogleMenu)];
    self.navigationItem.leftBarButtonItem=left;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier=@"shitCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor=BACKGROUND_COLOR;
    cell.textLabel.textColor=RGBCOLOR(135, 186, 225);
    if(indexPath.row==0)
    {
        cell.textLabel.text=@"连胜榜";
    }
    if(indexPath.row==1)
    {
        cell.textLabel.text=@"连败榜";
    }
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _detail=[[LXDetailViewController alloc] init];
    
    _detail.type=indexPath.row;
    [self.navigationController pushViewController:_detail animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

@end
