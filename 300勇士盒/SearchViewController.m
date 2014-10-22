//
//  SearchViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "SearchViewController.h"
#import "Role.h"
#import <AFHTTPRequestOperationManager.h>
#import "UIViewController+CHSideMenu.h"
#import "UConstants.h"
@interface SearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray *data;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    _bar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width*110/320)];
    _bar.backgroundImage=[UIImage imageNamed:@"background101020.png"];
    _bar.delegate=self;
    _bar.showsCancelButton=YES;
    _bar.showsScopeBar=YES;
    _bar.scopeButtonTitles = [NSArray arrayWithObjects:@"人",@"英雄",@"装备",nil];
    [self.view addSubview:_bar];
    [_bar becomeFirstResponder];
    
    _table=[[UITableView alloc] initWithFrame:CGRectMake(0,110, Main_Screen_Width, 600) style:UITableViewStylePlain];
    _table.delegate=self;
    _table.dataSource=self;
    _table.hidden=YES;
    [self.view addSubview:_table];
    
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _LodingActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    //_LodingActivityIndicator.center = CGPointMake(100.0f, 100.0f);//只能设置中心，不能设置大小
    _LodingActivityIndicator.frame=CGRectMake(0, 100, 320, 100);//不建议这样设置，因为UIActivityIndicatorView是不能改变大小只能改变位置，这样设置得到的结果是控件的中心在（100，100）上，而不是和其他控件的frame一样左上角在（100， 100）长为100，宽为100.
    [self.view addSubview:_LodingActivityIndicator];
    [_LodingActivityIndicator setColor:[UIColor grayColor]];
    [_LodingActivityIndicator startAnimating]; // 开始旋转
    //[testActivityIndicator stopAnimating]; // 结束旋转
    [_LodingActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain", nil];
    NSDictionary *paremeters=[NSDictionary dictionaryWithObjectsAndKeys:_bar.text,@"name",nil];
    [manager GET:@"http://300report.jumpw.com/api/getrole" parameters:paremeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_LodingActivityIndicator stopAnimating];
        NSLog(@"%@",responseObject);
        NSString *result=[responseObject objectForKey:@"Result"];
        if([result isEqualToString:@"OK"])
        {
            NSDictionary *dic=[responseObject objectForKey:@"Role"];
            Role *role=[[Role alloc] initWithObject:dic];
            data=[NSArray arrayWithObject:role];
            [_table reloadData];
            [_table setHidden:NO];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_LodingActivityIndicator stopAnimating];
        NSLog(@"%@",error);
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer=@"searchResult";
    UITableViewCell *cell=[_table dequeueReusableCellWithIdentifier:identifer];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    Role *role=data[indexPath.row];
    cell.textLabel.text=role.RoleName;
    
    
    return cell;
    
}
-(BOOL)prefersStatusBarHiddenChange{
    return NO;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    [_bar resignFirstResponder];
    //NSLog(@"%@",[self.presentingViewController class]);
    NSDictionary *Dic=[NSDictionary dictionaryWithObject:cell.textLabel.text forKey:@"name"];
    [self dismissViewControllerAnimated:YES completion:^{
         [[NSNotificationCenter defaultCenter] postNotificationName:@"do" object:self userInfo:Dic];
        //NSLog(@"%@",Dic);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
