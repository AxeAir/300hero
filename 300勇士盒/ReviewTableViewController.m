//
//  ReviewTableViewController.m
//  300勇士盒
//
//  Created by ChenHao on 1/3/15.
//  Copyright (c) 2015 xxTeam. All rights reserved.
//

#import "ReviewTableViewController.h"
#import "UConstants.h"
#import "WriteReviewViewController.h"
@interface ReviewTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ReviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTable];
    [self addReviewButton];
}

-(void)addTable
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height-64)];
    
    [self.view addSubview:_tableView];
}

- (void)addReviewButton
{
    UIButton *writeReview = [[UIButton alloc] initWithFrame:CGRectMake(0, Main_Screen_Height-64-40, Main_Screen_Width, 40)];
    [writeReview setTitle:@"我要写评论" forState:UIControlStateNormal];
    [writeReview setBackgroundColor:BACKGROUND_COLOR];
    [writeReview addTarget:self action:@selector(write) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:writeReview];
}

- (void)write
{
    WriteReviewViewController *write = [[WriteReviewViewController alloc] init];
    write.pageID=_pageID;
    [self.navigationController pushViewController:write animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer=@"reviewcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
