//
//  JHGridTableViewController.m
//  GridTableView
//
//  Created by 流星 on 14-5-14.
//  Copyright (c) 2014年 流星. All rights reserved.
//

#import "JHGridTableViewController.h"

@interface JHGridTableViewController ()<JHGridTableViewCellDelegate>

@end

@implementation JHGridTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(25, 0, 25, 0)];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    NSLog(@"ceil(%ld , %f) = %f",(long)[_datasource numberOfGrids],numberOfGridsInRow,ceil([_datasource numberOfGrids]/numberOfGridsInRow));
    return ceil([_datasource numberOfGrids]/numberOfGridsInRow);

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NSString *reuseIdtStr = [NSString stringWithFormat:@"JHGridViewCell-%d",indexPath.row];
    JHGridTableViewCell *cell = (JHGridTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdtStr];
    if (!cell) {
        
        cell = [[JHGridTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                         reuseIdentifier:reuseIdtStr
                                                delegate:self
                                               rowHeight:[self tableView:tableView heightForRowAtIndexPath:indexPath]
                                               indexPath:indexPath];
        
        
    }
    
    // Configure the cell...

    [self updateCell:cell];
    
    return cell;
    
}

// 更新Cell
- (void)updateCell:(JHGridTableViewCell *)cell{
    
    static int i = 0;
    
    if(i < numberOfGridsInRow){
        
        // 设置图片（更新操作）
        [cell.gridViews[i] setImage:[_datasource imageAtIndex:[cell.gridViews[i]index]]];
       
        // i++
        i++;
        
        // 继续更新
        [self updateCell:cell];
    }
    else{
        
        // 归零
        i =0;
    }
    
}

#pragma mark - JHGridTableViewCellDelegate
- (void)didTapGrid:(JHGridView *)gridView{
    
    [_delegate tableView:self.tableView didSelectGridView:gridView];
}



@end
