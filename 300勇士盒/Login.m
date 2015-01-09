//
//  Login.m
//  Login
//
//  Created by Yeti on 23/11/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import "Login.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"
#import "UConstants.h"
#import "MyPublic.h"
#import "LoginPublicClass.h"
#import <AVUser.h>
#import <AVAnonymousUtils.h>

@interface Login () <UIPickerViewDelegate, UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UITextFieldDelegate,SighUpDelegate>

//LOGO
@property (strong,nonatomic) UIImageView *logoImgView;

//引用
@property (strong,nonatomic) MyPublic* myPublic;
@property (strong,nonatomic) LoginPublicClass *loginPublicClass;

//登录
@property (strong,nonatomic) UITextField *accountTF;
@property (strong,nonatomic) UIButton *loginBtn;

//注册
@property (strong,nonatomic) UITextField *passwordTF;
@property (strong,nonatomic) UIButton *signUpBtn;

//性别
@property (strong,nonatomic) NSString *sex;

//全局
@property (strong,nonatomic) NSUserDefaults *userDefaults;
@property (strong,nonatomic) NSString *valid_filed;//登录方式
@property (strong,nonatomic) NSDictionary *userDic;

//布局
@property (assign,nonatomic) CGFloat halfWidth;
@property (assign,nonatomic) CGFloat viewHeight;
@property (strong,nonatomic) NSString *token;

//找回密码
@property (strong,nonatomic) UIButton *findPWBtn;

//跳过
@property (strong,nonatomic) UIButton *skipBtn;

@end

@implementation Login

#pragma mark-LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    //初始化引用类
    _myPublic = [[MyPublic alloc]init];
    _loginPublicClass = [[LoginPublicClass alloc]init];
    
    _userDefaults = [NSUserDefaults standardUserDefaults];
    
    _viewHeight = self.view.layer.frame.size.height;
    
    //iPhone6 到 iPhone 5 的大小比例系数
    float sixToFive = 1.17;
    
    // Do any additional setup after loading the view.

    if(ISIPHONE){
        UIImage*img =[UIImage imageNamed:@"loginBg"];
        UIImageView* bgview = [[UIImageView alloc]initWithImage:img];
        bgview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:bgview];
//        [self.view setBackgroundColor:[UIColor colorWithPatternImage:img]];
    }
//    if(ISIPHONE5){
//        UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"loginBg"]];
//        self.view.backgroundColor = background;
//    }
//    if(ISIPHONE6){
//        UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"loginBg"]];
//        self.view.backgroundColor = background;
//    }

    _halfWidth = self.view.frame.size.width/2;
    
    //general button config
    
    int width = 300;
    int height = 50;
    int space = 10;
    
    //logo
    
    int logoImgWidth = 100;
    int logoImgHeight = 100;
    float y = kStatusBarHeight; // y location
    
    if(ISIPHONE){
        logoImgHeight = 100;
        logoImgHeight = 100;
    }
    if(ISIPHONE5){
        logoImgWidth = 150/1.17;
        logoImgHeight = 150/1.17;
    }
    if(ISIPHONE6){
        logoImgHeight = 150;
        logoImgWidth = 150;
    }
    
    _logoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_halfWidth-logoImgWidth/2, y, logoImgWidth , logoImgHeight)];
    _logoImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    _logoImgView.layer.borderWidth = 0;
    _logoImgView.layer.cornerRadius = logoImgWidth/2;
    _logoImgView.layer.masksToBounds=YES;
    _logoImgView.userInteractionEnabled = YES;
    _logoImgView.image =[UIImage imageNamed:@"logo"];
    [self.view addSubview:_logoImgView];
    
    //账号
    
    if(ISIPHONE5){
        y += logoImgHeight + space/sixToFive * 4 ;
        width = width / sixToFive;
        height = height;
    }
    else if(ISIPHONE6){
        y += logoImgHeight + space * 4;
    }
    else{
        y += logoImgHeight + space/sixToFive * 2;
        width = width / sixToFive;
        height = height;
    }

    _accountTF = [[UITextField alloc] init];
    _accountTF.placeholder = @" 邮箱&手机";
    _accountTF.frame = CGRectMake(_halfWidth-width/2, y, width, height);
    _accountTF.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.3].CGColor;
    _accountTF.layer.cornerRadius =3;
    _accountTF.backgroundColor = [UIColor whiteColor];
    _accountTF.delegate = self;
    _accountTF.keyboardType = UIKeyboardTypeEmailAddress;
    _accountTF.returnKeyType=UIReturnKeyNext;
    _accountTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:_accountTF];
    
    //密码
    
    if(ISIPHONE5){
        y += height + space/sixToFive;
        width = width;
        height = height;
    }
    else if(ISIPHONE6){
        y += height + space;
    }
    else{
        y += height + space/sixToFive;
        width = width;
        height = height;
    }
    
    _passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(_halfWidth-width/2, y, width, height)];
    _passwordTF.placeholder = @" 密码";
    _passwordTF.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.1].CGColor;
    _passwordTF.layer.cornerRadius = 3;
    _passwordTF.backgroundColor = [UIColor whiteColor];
    _passwordTF.secureTextEntry = YES;
    _passwordTF.returnKeyType=UIReturnKeyJoin;
    _passwordTF.delegate = self;
    [self.view addSubview:_passwordTF];
    
    //loginBtn
    
    if(ISIPHONE5){
        y += height + space/sixToFive;
        width = width;
        height = height;
    }
    else if(ISIPHONE6){
        y += height + space;
    }
    else{
        y += height + space/sixToFive;
        width = width;
        height = height - 10;
    }

    _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(_halfWidth-width/2, y, width, height)];
    _loginBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.backgroundColor = [UIColor colorWithRed:107/255.0 green:215/255.0 blue:57/255.0 alpha:1];
    [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginBtnClickAV) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    //SignUp Btn
    
    if(ISIPHONE5){
        y += height + space/sixToFive;
        width = width;
        height = height;
    }
    else if(ISIPHONE6){
        y += height + space;
    }
    else{
        y += height + space/sixToFive;
        width = width;
        height = height;
    }
    
    y = _viewHeight - 50 - height * 2 - space/sixToFive;
    _signUpBtn = [[UIButton alloc]initWithFrame:CGRectMake(_halfWidth-width/2, y, width, height)];
    _signUpBtn.layer.cornerRadius = 5;
    _signUpBtn.backgroundColor = [UIColor colorWithRed:36/255.0 green:157/255.0 blue:237/255.0 alpha:1];
    [_signUpBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [_signUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_signUpBtn addTarget:self action:@selector(signUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_signUpBtn];
    
    //wechat
    
    if(ISIPHONE5){
        y += height + space/sixToFive;
        width = width;
        height = height;
    }
    else if(ISIPHONE6){
        y += height + space;
    }
    else{
        y += height + space/sixToFive;
        width = width;
        height = height;
    }
    
    //Skip Btn
    
    if(ISIPHONE5){
        y += height + space/sixToFive;
        width = width;
        height = height;
    }
    else if(ISIPHONE6){
        y += height + space;
    }
    else{
        y += height + space/sixToFive;
        width = width;
        height = height;
    }
    
    width = 200;
    y = _viewHeight - 50;
    _skipBtn = [[UIButton alloc]initWithFrame:CGRectMake(_halfWidth-width/2, y, width, height)];
    _skipBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    [_skipBtn setTitle:@"跳 过" forState:UIControlStateNormal];
    _skipBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_skipBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_skipBtn addTarget:self action:@selector(skipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_skipBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_accountTF isExclusiveTouch]) {
        [_accountTF resignFirstResponder];
    }
    if (![_passwordTF isExclusiveTouch]) {
        [_passwordTF resignFirstResponder];
    }
}

#pragma mark-TouchEvent


-(void)loginBtnClickAV{
    if([MyPublic isPhoneNumber:_accountTF.text]){
        [AVUser logInWithMobilePhoneNumberInBackground:_accountTF.text password:_passwordTF.text block:^(AVUser *user, NSError *error) {
            if(user!=nil){
                [self dismissViewControllerAnimated:YES completion:nil];
//                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            if(error!=nil){
                UIAlertView *failLogin = [[UIAlertView alloc]initWithTitle:@"提示" message:@"账号或密码错误" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                [failLogin show];
            }
            
        }];
    }else if([MyPublic validateEmail:_accountTF.text]){
        [AVUser logInWithUsernameInBackground:_accountTF.text password:_passwordTF.text block:^(AVUser *user, NSError *error) {
            if(user!=nil){
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                UIAlertView *failLogin = [[UIAlertView alloc]initWithTitle:@"提示" message:@"账号或密码错误" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                [failLogin show];
            }
        }];
    }else{
        UIAlertView *failLogin = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入手机号或邮箱" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [failLogin show];
        [_accountTF becomeFirstResponder];
    }
}

- (void)signUpBtnClick{
    
    SighUP *signUpView = [[SighUP alloc] init];
    [self.navigationController pushViewController:signUpView animated:YES];//  SighUP *signUpView=[[SighUP alloc] initWithNibName:@"signUpView" bundle:nil];
    signUpView.delegate = self;

}

- (void)skipBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)wechatBtnClick{
    
}
#pragma mark-TextField Delegate

/*
 *   重写键盘回车键
 */
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    UITextField *next = theTextField;
    if (next == _accountTF) {
        [_passwordTF  becomeFirstResponder];
    }else if(next == _passwordTF){
        [_loginBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect curFrame = self.view.frame;
    curFrame.origin.y -= 30;
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame=curFrame;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    CGRect curFrame = self.view.frame;
    curFrame.origin.y += 30;
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame=curFrame;
    }];
}

#pragma mark-Action

- (BOOL)prefersStatusBarHidden{
    return YES;//隐藏为YES，显示为NO
}


@end
