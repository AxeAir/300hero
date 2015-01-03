//
//  NewEquipViewController.m
//  300勇士盒
//
//  Created by ChenHao on 1/3/15.
//  Copyright (c) 2015 xxTeam. All rights reserved.
//

#import "NewEquipViewController.h"
#import "UConstants.h"
#import "CacheEntence.h"
#import <JSONKit-NoWarning/JSONKit.h>

@interface NewEquipViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, assign) NSInteger        currentTAG;
@property (nonatomic, strong) UIView           *view1;
@property (nonatomic, strong) UIView           *view2;
@property (nonatomic, strong) UIView           *view3;
@property (nonatomic, strong) NSMutableArray   *array1;
@property (nonatomic, strong) NSMutableArray   *array2;
@property (nonatomic, strong) NSMutableArray   *array3;

@end

@implementation NewEquipViewController
static NSString * const reuseIdentifier = @"CollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layout];
    [self initVar];
    
}

- (void)initVar
{
    _array1 = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", nil];
    _array2 = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", nil];
    _array3 = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", nil];
    
}

- (void)layout
{
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(submit)];
    [self.navigationItem setRightBarButtonItem:right];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _view1=[self AddEquipView:CGRectMake(15, 20, Main_Screen_Width-30, 200) discription:@"前期" TAGstart:10000];
    [self.view addSubview:_view1];
    
    _view2=[self AddEquipView:CGRectMake(15, MaxY(_view1), Main_Screen_Width-30, 200) discription:@"中期" TAGstart:20000];
    [self.view addSubview:_view2];
    
    _view3=[self AddEquipView:CGRectMake(15, MaxY(_view2), Main_Screen_Width-30, 200) discription:@"后期" TAGstart:30000];
    [self.view addSubview:_view3];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize=CGSizeMake((Main_Screen_Width-60)/6,(Main_Screen_Width-60)/6);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    _collection=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 150, Main_Screen_Width, Main_Screen_Height-150-64) collectionViewLayout:flowLayout];
    [_collection setBackgroundColor:[UIColor whiteColor]];
    [_collection setDelegate:self];
    [_collection setDataSource:self];
    [_collection setHidden:YES];
    
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_collection];
    
    
}

- (UIView *)AddEquipView:(CGRect)frame discription:(NSString *)discription TAGstart:(NSInteger)start
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UILabel *dis = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width-20, 20)];
    dis.text=discription;
    [dis setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:dis];
    
    float width=(frame.size.width-25)/6.0;
    
    for (int i=0;i<6;i++) {
        UIImageView *img= [[UIImageView alloc] initWithFrame:CGRectMake((width+5)*i, 22, width, width)];
        [img setImage:[UIImage imageNamed:@"add"]];
        img.tag= start+i;
        [[img layer] setBorderWidth:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectEquip:)];
        [img addGestureRecognizer:tap];
        [img setUserInteractionEnabled:YES];
        [view addSubview:img];
    }
    
    UITextField *text=[[UITextField alloc] initWithFrame:CGRectMake(0, 25+width, WIDTH(view), 50)];
    [[text layer] setBorderWidth:0.5];
    [text setPlaceholder:@"简单介绍"];
    text.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    [view addSubview:text];
    CGRect f= view.frame;
    f.size.height=MaxY(text);
    view.frame= f;
    
    return view;
}
/**
 *  提交到服务器
 */
- (void)submit
{
    
    NSString *common1;
    NSString *common2;
    NSString *common3;
    for (UIView *v in _view1.subviews) {
        if ([v isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)v;
            common1 = textField.text;
        }
    }
    
    for (UIView *v in _view2.subviews) {
        if ([v isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)v;
            common2 = textField.text;
        }
    }
    
    for (UIView *v in _view3.subviews) {
        if ([v isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)v;
            common3 = textField.text;
        }
    }
    
    NSDictionary *dic1=[NSDictionary dictionaryWithObjectsAndKeys:_array1,@"equip",common1,@"common", nil];
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:_array2,@"equip",common1,@"common", nil];
    NSDictionary *dic3=[NSDictionary dictionaryWithObjectsAndKeys:_array3,@"equip",common1,@"common", nil];
    
    NSArray *equipList=[NSArray arrayWithObjects:dic1,dic2,dic3, nil];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"yeti",[equipList JSONString],[NSString stringWithFormat:@"%ld",_heroID], nil] forKeys:[NSArray arrayWithObjects:@"userID",@"equipList",@"heroID", nil]];
    
    NSLog(@"%@",dic);
    [CacheEntence POSTRequestRemoteURL:@"http://219.153.64.13:8520/addHeroEquip/" paramters:dic Cache:NO success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)selectEquip:(UITapGestureRecognizer *)recognizer
{
    NSInteger tag = recognizer.view.tag;
    _currentTAG = tag;
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = _collection.frame;
        if (tag/10000==1) {
            frame.origin.y = MaxY(_view1);
        }
        else if (tag/10000==2) {
            frame.origin.y = MaxY(_view2);
        }
        else if (tag/10000==3) {
            frame.origin.y = MaxY(_view3);
        }
        
        _collection.frame=frame;
        [_collection setHidden:NO];
    }];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 131;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = (UICollectionViewCell*)[_collection dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UICollectionViewCell alloc] init];
    }
    else
    {
        for (UIView *v in cell.contentView.subviews) {
            [v removeFromSuperview];
        }
    }
    
    UIImage *image= [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(long)indexPath.row+1]];
    //[cell layout:model];
    UIImageView *imageview=[[UIImageView alloc] initWithImage:image];
    [imageview setFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    
    [cell addSubview:imageview];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentTAG/10000==1) {
        [_array1 replaceObjectAtIndex:_currentTAG-10000 withObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
        
    }
    else if (_currentTAG/10000==2) {
        [_array2 replaceObjectAtIndex:_currentTAG-20000 withObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    }
    else if (_currentTAG/10000==3) {
        [_array3 replaceObjectAtIndex:_currentTAG-30000 withObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    }
    
    UIImageView *view =(UIImageView *)[self.view viewWithTag:_currentTAG];
    [view setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",indexPath.row+1]]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_collection setHidden:YES];
}






@end
