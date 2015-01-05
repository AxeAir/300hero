//
//  LoginWechat.m
//  SportMan
//
//  Created by Yeti on 29/11/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "LoginWechat.h"
#import "UConstants.h"

@interface LoginWechat ()

@property (strong,nonatomic) UIImageView *logoImgView;
@property (strong,nonatomic) NSString *wechatID;
@property (strong,nonatomic) NSString *weiboID;
@property (strong,nonatomic) UIImageView *wechatImgView;
@property (strong,nonatomic) UIImageView *weiboImgView;
@property (strong,nonatomic) UIButton *loginBtn;
@property (strong,nonatomic) UIButton *signUpBtn;
@property (strong,nonatomic) UIButton *skipBtn;
@property (strong,nonatomic) NSUserDefaults *userDefaults;
@property (strong,nonatomic) NSString *valid_filed;//登录方式
@property (assign,nonatomic) CGFloat halfWidth;

@end

@implementation LoginWechat

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:120/255.0 green:177/255.0 blue:255/255.0 alpha:1.0];
    _halfWidth = self.view.frame.size.width/2;
    
    //logo
    int width = 200;
    int height = 30;
    int space = 10;
    int y = kStatusBarHeight;
    _logoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_halfWidth-150/2, y, 150, 150)];
    _logoImgView.backgroundColor = [UIColor whiteColor];
    _logoImgView.layer.borderColor = [UIColor grayColor].CGColor;
    _logoImgView.layer.borderWidth = 0;
    _logoImgView.userInteractionEnabled = YES;
    _logoImgView.image =[UIImage imageNamed:@"logo"];
    
    //wechatView
    width = 200;
    y += height +space;
    _wechatImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_halfWidth-width/2, y, width, height)];
    _wechatImgView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
    _wechatImgView.layer.borderWidth = 1;
    _wechatImgView.backgroundColor = [UIColor grayColor];
//    [_wechatImgView setTitle:@"微信账号登录" forState:UIControlStateNormal];
//    [_wechatImgView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_wechatImgView addTarget:self action:@selector(wechatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wechatImgView];
    
    //weiboView
    width = 200;
    y += height +space;
    _weiboImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_halfWidth-width/2, y, width, height)];
    _weiboImgView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
    _weiboImgView.layer.borderWidth = 1;
    _weiboImgView.backgroundColor = [UIColor grayColor];
    //    [_wechatImgView setTitle:@"微信账号登录" forState:UIControlStateNormal];
    //    [_wechatImgView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [_wechatImgView addTarget:self action:@selector(wechatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_weiboImgView];
    
    //Skip Btn
    width = 200;
    y += height +space;
    _skipBtn = [[UIButton alloc]initWithFrame:CGRectMake(_halfWidth-width/2, y, width, height)];
    _skipBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    [_skipBtn setTitle:@"跳 过" forState:UIControlStateNormal];
    _skipBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
    [_skipBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_skipBtn addTarget:self action:@selector(skipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_skipBtn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
