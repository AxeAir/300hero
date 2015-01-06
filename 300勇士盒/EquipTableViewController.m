//
//  EquipTableViewController.m
//  300勇士盒
//
//  Created by ChenHao on 1/4/15.
//  Copyright (c) 2015 xxTeam. All rights reserved.
//

#import "EquipTableViewController.h"
#import "SingleEquipTableViewCell.h"
#import <JSONKit.h>
@interface EquipTableViewController ()

@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSArray      *equipData;

@end

@implementation EquipTableViewController

- (instancetype)iniWithDictionary:(NSDictionary *)dic
{
    if(self)
    {
        _dictionary=dic;
    }
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    NSLog(@"%@",_dictionary);
    
    NSDictionary *json = [_dictionary objectForKey:@"equipJson"];
    
    NSDictionary *qian =  [json objectForKey:@"qian"];
    NSDictionary *zhong = [json objectForKey:@"zhong"];
    NSDictionary *hou =   [json objectForKey:@"hou"];

    _equipData = [NSArray arrayWithObjects:qian,zhong,hou ,nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingleEquipTableViewCell *cell = (SingleEquipTableViewCell*) [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer=@"equipcell";
    SingleEquipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell = [[SingleEquipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    UILabel *common = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 80, 20)];
    [common setFont:[UIFont systemFontOfSize:14]];
    [common setTextColor:[UIColor blackColor]];
    if (indexPath.row==0) {
        [common setText:[NSString stringWithFormat:@"前期"]];
    }
    if (indexPath.row==1) {
        [common setText:[NSString stringWithFormat:@"中期"]];
    }
    if (indexPath.row==2) {
        [common setText:[NSString stringWithFormat:@"后期"]];
    }
    
    [cell .contentView addSubview:common];
    [cell configDetail:[_equipData objectAtIndex:indexPath.row]];
    
    return cell;
}



@end
