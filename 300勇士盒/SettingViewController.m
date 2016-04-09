//
//  SettingViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/20/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "SettingViewController.h"


@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"设置";
    [self setupTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupTable {
    _Settingtable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 600) style:UITableViewStyleGrouped];
    _Settingtable.delegate=self;
    _Settingtable.dataSource=self;
    [self.view addSubview:_Settingtable];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer=@"settingcell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=@"清除缓存";
            break;
        case 1:
            cell.textLabel.text=@"版本更新";
            break;
        default:
            break;
    }
    
    return cell;
}

@end
