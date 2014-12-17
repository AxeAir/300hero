//
//  HeroCollectionViewController.m
//  300勇士盒
//
//  Created by ChenHao on 12/10/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "HeroCollectionViewController.h"
#import "UIViewController+CHSideMenu.h"
#import "CollectionViewCell.h"
#import "UConstants.h"
#import "HYSegmentedControl.h"
#import <AFHTTPRequestOperationManager.h>
#import "UConstants.h"
#import "HeroListModel.h"
#import "DetailHeroViewController.h"
#import <AVOSCloud/AVOSCloud.h>


@interface HeroCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,HYSegmentedControlDelegate>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) HYSegmentedControl *segment;

@property (nonatomic, strong) NSArray *heroList;
@end

@implementation HeroCollectionViewController

static NSString * const reuseIdentifier = @"CollectionViewCell";




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize=CGSizeMake((Main_Screen_Width-50)/4,(Main_Screen_Width-50)/4+20);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10.0, 5, 10.0);
    
    _segment=[[HYSegmentedControl alloc] initWithOriginY:0 Titles:@[@"免费英雄", @"全部英雄", @"英雄收藏"] delegate:self];
    [self.view addSubview:_segment];

    
    _collection=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, Main_Screen_Width, Main_Screen_Height-40-64) collectionViewLayout:flowLayout];
    [_collection setBackgroundColor:[UIColor whiteColor]];
    [_collection setDelegate:self];
    [_collection setDataSource:self];
    
    [_collection registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_collection];
    
    [self collectionconfig];
    [self getRemoteList:0];
}


- (void)getRemoteList:(NSInteger)freetype
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@getHeroList/?freeType=%ld",DEBUG_URL,(long)freetype];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *status=[responseObject objectForKey:@"Status"];
        if ([status isEqualToString:@"OK"]) {
            _heroList=[HeroListModel getHerolist:[responseObject objectForKey:@"Result"]];
            [_collection reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [AVAnalytics beginLogPageView:@"英雄页面"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [AVAnalytics endLogPageView:@"英雄页面"];
}

- (void)collectionconfig
{
    self.title=@"英雄";
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1] forKey:NSForegroundColorAttributeName];
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"burger"] style:UIBarButtonItemStyleDone target:self action:@selector(toogleMenu)];
    self.navigationItem.leftBarButtonItem=left;
}

- (void)toogleMenu
{
    [self.navigationController.sideMenuController toggleMenu:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [_heroList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell * cell = (CollectionViewCell*)[_collection dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[CollectionViewCell alloc] init];
    }
    else
    {
        for (UIView *v in cell.contentView.subviews) {
            [v removeFromSuperview];
        }
    }

    HeroListModel *model=_heroList[indexPath.row];
    [cell layout:model];

    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}
*/
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {

    NSLog(@"dd");
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroListModel *hero=[_heroList objectAtIndex:indexPath.row];
    DetailHeroViewController *detail=[[DetailHeroViewController alloc] initWithHeroID:hero.heroid];
    [self.navigationController pushViewController:detail animated:YES];
}




- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            [self getRemoteList:0];
            
            break;
        case 1:
            [self getRemoteList:-1];
            break;
        case 2:
            
            break;
            
        default:
            break;
    }
}

@end
