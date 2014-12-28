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


@interface HeroCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,HYSegmentedControlDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) HYSegmentedControl *segment;
@property (nonatomic ,strong) UITextField *searchField;
@property (nonatomic, strong) NSArray *heroList;
@property (nonatomic, strong) NSArray *heroListchoose;
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
    
    _segment=[[HYSegmentedControl alloc] initWithOriginY:0 Titles:@[@"免费英雄", @"全部英雄"] delegate:self];
//    _segment=[[HYSegmentedControl alloc] initWithOriginY:0 Titles:@[@"免费英雄", @"全部英雄", @"英雄收藏"] delegate:self];
    [self.view addSubview:_segment];

    
    _collection=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, Main_Screen_Width, Main_Screen_Height-40-64) collectionViewLayout:flowLayout];
    [_collection setBackgroundColor:[UIColor whiteColor]];
    [_collection setDelegate:self];
    [_collection setDataSource:self];
    
    [_collection registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_collection];
    
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(10, 40, Main_Screen_Width-20, 40)];
    [_searchField setPlaceholder:@"英雄名称"];
    [_searchField setHidden:YES];
    [_searchField setDelegate:self];
    [_searchField addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventAllEditingEvents];
    [self.view addSubview:_searchField];
    
    [self collectionconfig];
    [self getRemoteList:0];
}


- (void)getRemoteList:(NSInteger)freetype
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@getHeroList/?freeType=%ld",DEBUG_URL,(long)freetype];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *status=[responseObject objectForKey:@"Status"];
        if ([status isEqualToString:@"OK"]) {
            _heroList=[HeroListModel getHerolist:[responseObject objectForKey:@"Result"]];
            _heroListchoose= _heroList;
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

    return [_heroListchoose count];
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

    HeroListModel *model=_heroListchoose[indexPath.row];
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

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_searchField resignFirstResponder];
    HeroListModel *hero=[_heroListchoose objectAtIndex:indexPath.row];
    DetailHeroViewController *detail=[[DetailHeroViewController alloc] initWithHeroID:hero.heroid];
    [self.navigationController pushViewController:detail animated:YES];
}




- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    [_searchField resignFirstResponder];
    switch (index) {
        case 0:{
            [self getRemoteList:0];
            [UIView animateWithDuration:0.5 animations:^{
                [_collection setFrame:CGRectMake(0, 40, Main_Screen_Width, Main_Screen_Height-40-64)];
                [_searchField setHidden:YES];
            }];
        }
            
            break;
        case 1:
            {
            [self getRemoteList:-1];
            [UIView animateWithDuration:0.5 animations:^{
                [_collection setFrame:CGRectMake(0, 80, Main_Screen_Width, Main_Screen_Height-80-64)];
                [_searchField setHidden:NO];
            }];
        }
            break;
        case 2:
            
            break;
            
        default:
            break;
    }
}

- (void)valueChange
{
    if(_searchField.text.length==0)
    {
        _heroListchoose=_heroList;
    }
    else
    {
        //使用OR和SELF（数据成员本身）
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@",_searchField.text];
        _heroListchoose=[_heroList filteredArrayUsingPredicate:predicate];
    }
    [self.collection reloadData];
}

@end
