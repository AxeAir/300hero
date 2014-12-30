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


@property (nonatomic, strong) UIView *typeView;
@property (nonatomic, strong) UIButton *Lbutton;
@property (nonatomic, strong) UIButton *Cbutton;
@property (nonatomic, strong) UIButton *ATKbutton;
@property (nonatomic, strong) UIButton *APbutton;
@property (nonatomic, strong) UIButton *TANKbutton;
@property (nonatomic, strong) UIButton *HELPbutton;
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

    
    _collection=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, Main_Screen_Width, Main_Screen_Height-50-64) collectionViewLayout:flowLayout];
    [_collection setBackgroundColor:[UIColor whiteColor]];
    [_collection setDelegate:self];
    [_collection setDataSource:self];
    
    [_collection registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_collection];
    
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(10, 55, Main_Screen_Width-20, 45)];
    [_searchField setPlaceholder:@"请输入你想要查找的英雄名称"];
    [_searchField setHidden:YES];
    [_searchField setDelegate:self];
    [[_searchField layer] setBorderWidth:1.0];
    [[_searchField layer] setCornerRadius:4.0];
    [_searchField addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventAllEditingEvents];
    [self.view addSubview:_searchField];
    
    
    _typeView = [[UIView alloc] initWithFrame:CGRectMake(10, MaxY(_searchField)+5, Main_Screen_Width, 20)];
    
    _Lbutton = [[UIButton alloc] init];
    [_Lbutton setTitle:@"远程" forState:UIControlStateNormal];
    [_Lbutton setFrame:CGRectMake(0, 0, (Main_Screen_Width-10)/6-10, 20)];
    [_Lbutton setBackgroundColor:[UIColor redColor]];
    
    [_Lbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[_Lbutton titleLabel] setFont:[UIFont boldSystemFontOfSize:14]];
    [[_Lbutton layer] setCornerRadius:5.0];
    [_Lbutton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_Lbutton setTitle:@" " forState:UIControlStateSelected];
    [_Lbutton setBackgroundImage:[UIImage imageNamed:@"logo"] forState:UIControlStateSelected];
    [_Lbutton setTag:800001];
    
    _Cbutton = [[UIButton alloc] init];
    [_Cbutton setTitle:@"近战" forState:UIControlStateNormal];
    [_Cbutton setFrame:CGRectMake(MaxX(_Lbutton)+10,0 , (Main_Screen_Width-10)/6-10, 20)];
    [_Cbutton setBackgroundColor:[UIColor blueColor]];
    [_Cbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[_Cbutton titleLabel] setFont:[UIFont boldSystemFontOfSize:14]];
    [[_Cbutton layer] setCornerRadius:5.0];
    [_Cbutton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_Cbutton setTitle:@" " forState:UIControlStateSelected];
    [_Cbutton setBackgroundImage:[UIImage imageNamed:@"logo"] forState:UIControlStateSelected];
    [_Cbutton setTag:800002];
    
    _ATKbutton = [[UIButton alloc] init];
    [_ATKbutton setTitle:@"物理" forState:UIControlStateNormal];
    [_ATKbutton setFrame:CGRectMake(MaxX(_Cbutton)+10,0 , (Main_Screen_Width-10)/6-10, 20)];
    [_ATKbutton setBackgroundColor:[UIColor purpleColor]];
    [[_ATKbutton layer] setCornerRadius:5.0];
    [[_ATKbutton titleLabel] setFont:[UIFont boldSystemFontOfSize:14]];
    [[_ATKbutton layer] setCornerRadius:5.0];
    [_ATKbutton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_ATKbutton setTitle:@" " forState:UIControlStateSelected];
    [_ATKbutton setBackgroundImage:[UIImage imageNamed:@"logo"] forState:UIControlStateSelected];
    [_ATKbutton setTag:800003];
    
    _APbutton = [[UIButton alloc] init];
    [_APbutton setTitle:@"法术" forState:UIControlStateNormal];
    [_APbutton setFrame:CGRectMake(MaxX(_ATKbutton)+10,0 ,(Main_Screen_Width-10)/6-10, 20)];
    [_APbutton setBackgroundColor:[UIColor lightGrayColor]];
    [[_APbutton layer] setCornerRadius:5.0];
    [[_APbutton titleLabel] setFont:[UIFont boldSystemFontOfSize:14]];
    [[_APbutton layer] setCornerRadius:5.0];
    [_APbutton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_APbutton setTitle:@" " forState:UIControlStateSelected];
    [_APbutton setBackgroundImage:[UIImage imageNamed:@"logo"] forState:UIControlStateSelected];
    [_APbutton setTag:800004];
    
    _TANKbutton = [[UIButton alloc] init];
    [_TANKbutton setTitle:@"肉盾" forState:UIControlStateNormal];
    [_TANKbutton setFrame:CGRectMake(MaxX(_APbutton)+10,0 , (Main_Screen_Width-10)/6-10, 20)];
    [_TANKbutton setBackgroundColor:[UIColor orangeColor]];
    [[_TANKbutton layer] setCornerRadius:5.0];
    [[_TANKbutton titleLabel] setFont:[UIFont boldSystemFontOfSize:14]];
    [[_TANKbutton layer] setCornerRadius:5.0];
    [_TANKbutton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_TANKbutton setTitle:@" " forState:UIControlStateSelected];
    [_TANKbutton setBackgroundImage:[UIImage imageNamed:@"logo"] forState:UIControlStateSelected];
    [_TANKbutton setTag:800005];
    
    _HELPbutton = [[UIButton alloc] init];
    [_HELPbutton setTitle:@"辅助" forState:UIControlStateNormal];
    [_HELPbutton setFrame:CGRectMake(MaxX(_TANKbutton)+10,0 , (Main_Screen_Width-10)/6-10, 20)];
    [_HELPbutton setBackgroundColor:[UIColor greenColor]];
    [[_HELPbutton layer] setCornerRadius:5.0];
    [[_HELPbutton titleLabel] setFont:[UIFont boldSystemFontOfSize:14]];
    [[_HELPbutton layer] setCornerRadius:5.0];
    [_HELPbutton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_HELPbutton setTitle:@" " forState:UIControlStateSelected];
    [_HELPbutton setBackgroundImage:[UIImage imageNamed:@"logo"] forState:UIControlStateSelected];
    [_HELPbutton setTag:800006];
    
    [_typeView addSubview:_ATKbutton];
    [_typeView addSubview:_APbutton];
    [_typeView addSubview:_TANKbutton];
    [_typeView addSubview:_HELPbutton];
    
    [_typeView addSubview:_Cbutton];
    [_typeView addSubview:_Lbutton];
    [_typeView setHidden:YES];
    [self.view addSubview:_typeView];
    
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
                [_typeView setHidden:YES];
                [_typeView setAlpha:0.0];
            }];
        }
            
            break;
        case 1:
            {
            [self getRemoteList:-1];
            [UIView animateWithDuration:0.5 animations:^{
                [_collection setFrame:CGRectMake(0, 130, Main_Screen_Width, Main_Screen_Height-130-64)];
                [_searchField setHidden:NO];
                [_typeView setAlpha:1.0];
                [_typeView setHidden:NO];
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


- (void)selectButton:(UIButton *)sender
{
    NSArray *a=@[@"L",@"C",@"ATK",@"AP",@"TANK",@"HELP"];
    NSString *cl=[[NSString alloc] init];
    NSString *type=[[NSString alloc] init];
    if (sender.tag==800001||sender.tag==800002) {
        BOOL hasCl=NO;
        int i=0;
        //查看是否存在已经选得
        for (i=800001; i<=800002; i++) {
            UIButton *button=(UIButton *)[self.view viewWithTag:i];
            if(button.selected==YES)
            {
                hasCl=YES;
                break;
            }
        }
        //存在选择
        if (hasCl==YES) {
            UIButton *button=(UIButton *)[self.view viewWithTag:i];
            if (button.tag==sender.tag) {
                button.selected=NO;
                cl=@"";
            }
            else
            {
                sender.selected=YES;
                button.selected=NO;
                cl=[NSString stringWithFormat:@"%@",[a objectAtIndex:sender.tag-800000-1]];
            }
        }
        else
        {
            sender.selected=YES;
            cl=[NSString stringWithFormat:@"%@",[a objectAtIndex:sender.tag-800000-1]];
        }
        
        
        
        for (int j=800003; j<=800006; j++) {
            UIButton *button=(UIButton *)[self.view viewWithTag:j];
            if (button.selected==YES) {
                type=[NSString stringWithFormat:@"%@",[a objectAtIndex:j-800000-1]];
            }
        }
        
        
    }
    
    
    

    if (sender.tag>=800003&&sender.tag<=800006) {
        BOOL hasType=NO;
        int i=0;
        //查看是否存在已经选得
        for (i=800003; i<=800006; i++) {
            UIButton *button=(UIButton *)[self.view viewWithTag:i];
            if(button.selected==YES)
            {
                hasType=YES;
                break;
            }
        }
        //存在选择
        if (hasType==YES) {
            UIButton *button=(UIButton *)[self.view viewWithTag:i];
            if (button.tag==sender.tag) {
                button.selected=NO;
            }
            else
            {
                sender.selected=YES;
                button.selected=NO;
                type=[NSString stringWithFormat:@"%@",[a objectAtIndex:sender.tag-800000-1]];
            }
        }
        else
        {
            sender.selected=YES;
            type=[NSString stringWithFormat:@"%@",[a objectAtIndex:sender.tag-800000-1]];
        }

        
        
        for (int j=800001; j<=800002; j++) {
            UIButton *button=(UIButton *)[self.view viewWithTag:j];
            if (button.selected==YES) {
                cl=[NSString stringWithFormat:@"%@",[a objectAtIndex:j-800000-1]];
            }
        }
        

    }
    
   
    //sender.selected=!sender.selected;
    //使用OR和SELF（数据成员本身）
    NSPredicate *predicate = nil;
    if (cl.length!=0&&type.length!=0) {
        NSLog(@"atk_type CONTAINS %@ AND type CONTAINS %@",cl,type);
        predicate = [NSPredicate predicateWithFormat:@"atk_type CONTAINS %@ AND type CONTAINS %@",cl,type];
    }
    else if(cl.length==0)
    {
        NSLog(@"%@%@",cl,type);
        //predicate = [NSPredicate predicateWithFormat:@"%@%@",cl,type];
        predicate = [NSPredicate predicateWithFormat:@"type CONTAINS %@",type];
    }
    else if (type.length==0)
    {
        predicate = [NSPredicate predicateWithFormat:@"atk_type CONTAINS %@",cl];
    }
    
    _heroListchoose=[_heroList filteredArrayUsingPredicate:predicate];
    if (cl.length==0&&type.length==0) {
        _heroListchoose=_heroList;
    }
    [self.collection reloadData];

}

@end
