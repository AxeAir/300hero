//
//  ViewController.m
//  Login
//
//  Created by Yeti on 13/11/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import "SighUP.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"
#import <sys/sysctl.h>
#import "UConstants.h"
#import "MyPublic.h"
#import "LoginPublicClass.h"
#import <AVUser.h>
#import <AVOSCloudSNS.h>
#import "ValidMobile.h"
#import "PhotoStackView.h"
#import "PhotoStackViewController.h"

@interface SighUP () <UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UITextFieldDelegate,PhotoStackViewControllerDelegate>

//头像
@property (strong,nonatomic) NSString *imgPath;
@property (strong,nonatomic) NSString *avatarNum;
@property (strong,nonatomic) UIImagePickerController *picker;
@property (strong,nonatomic) UIImagePickerController *pickerImage;
@property (strong,nonatomic) UIImageView *cameraImg;
@property (strong,nonatomic) UIActionSheet *camSheet;
@property (strong,nonatomic) PhotoStackViewController *photoStack;

//ToolBar
@property (strong,nonatomic) UIToolbar *toolBar;
@property (strong,nonatomic) UIBarButtonItem *toolDoneBtn;
@property (strong,nonatomic) UIBarButtonItem *toolCancleBtn;
@property (strong,nonatomic) UIBarButtonItem *toolBarSpaceBtn;

//全局
@property (strong,nonatomic) NSUserDefaults *userDefaults;
@property (strong,nonatomic) MyPublic *myPublic;
@property (strong,nonatomic) LoginPublicClass *loginPublicClass;
@property (assign,nonatomic) CGFloat halfWidth;
@property (strong,nonatomic) UIButton *saveBtn;
@property (strong,nonatomic) UIButton *backBtn;
@property (assign,nonatomic) NSString *alert;
@property (strong,nonatomic) NSDictionary *userDic;


//昵称
@property (strong,nonatomic) UITextField *nickNameTF;
@property (strong,nonatomic) NSString *nickNameStr;

//账户
@property (strong,nonatomic) NSString *accountType;//登录方式  0.手机 1.邮箱
@property (strong,nonatomic) UITextField *accountTF;
@property (strong,nonatomic) NSString *accountStr;
@property (strong,nonatomic) NSString *token;

//验证码
@property (strong,nonatomic) ValidMobile *validMobile;


//密码
@property (strong,nonatomic) UITextField *passwordTF;
@property (strong,nonatomic) NSString *passwordStr;

@end

@implementation SighUP

#pragma mark - Lifecycle

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    PhotoStackViewController *photo = [[PhotoStackViewController alloc]init];
    photo.delegate = self;
    
    if(ISIPHONE){
        UIImage*img =[UIImage imageNamed:@"loginBg"];
        UIImageView* bgview = [[UIImageView alloc]initWithImage:img];
        bgview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:bgview];
    }
    
    _myPublic = [[MyPublic alloc] init];
    _loginPublicClass = [[LoginPublicClass alloc]init];
    
    _halfWidth = self.view.frame.size.width/2;
    
    //Camera
    int width = 250;
    int height = 40;
    int space = 8;
    int y = 30;
    _cameraImg = [[UIImageView alloc]initWithFrame:CGRectMake(_halfWidth-54, y, 100, 100)];
    _cameraImg.image = [UIImage imageNamed:@"a1.jpg"];
    _cameraImg.backgroundColor = [UIColor whiteColor];
    _cameraImg.layer.cornerRadius = 4;
    _cameraImg.layer.masksToBounds = YES;
    _cameraImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cameraTouch)];
    [_cameraImg addGestureRecognizer:tap];
    [self.view addSubview:_cameraImg];
    
    //nickName
    y += 108 + space*6;
    width = 250;
    _nickNameTF = [[UITextField alloc] init];
    _nickNameTF.placeholder = @" 游戏中の昵称";
    _nickNameTF.frame = CGRectMake(_halfWidth-width/2, y, width, height);
    _nickNameTF.layer.cornerRadius = 3;
    _nickNameTF.keyboardType = UIKeyboardTypeDefault;
    _nickNameTF.returnKeyType = UIReturnKeyNext;
    _nickNameTF.backgroundColor = [UIColor whiteColor];
    _nickNameTF.delegate = self;
    [self.view addSubview:_nickNameTF];
    
    //account
    y += height + space;
    _accountTF = [[UITextField alloc] init];
    _accountTF.placeholder = @" 你の电子邮箱/手机号码";
    _accountTF.frame = CGRectMake(_halfWidth-width/2, y, width, height);
    _accountTF.layer.cornerRadius = 3;
    _accountTF.backgroundColor = [UIColor whiteColor];
    _accountTF.keyboardType = UIKeyboardTypeEmailAddress;
    _accountTF.returnKeyType = UIReturnKeyNext;
    _accountTF.delegate = self;
    [self.view addSubview:_accountTF];

    
    //Password
    y += height + space;
    _passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(_halfWidth-width/2, y, width, height)];
    _passwordTF.placeholder = @" 你の密码";
    _passwordTF.layer.cornerRadius = 3;
    _passwordTF.backgroundColor = [UIColor whiteColor];
    _passwordTF.returnKeyType = UIReturnKeyGo;
    _passwordTF.keyboardType = UIKeyboardTypeDefault;
    _passwordTF.secureTextEntry = NO;
    _passwordTF.delegate = self;
    [self.view addSubview:_passwordTF];

    //SignUpBtn
    width = 150;
    height = 30;
    y += height + space*8;
    
    //Back
    width = 150;
    y += 30+ space*0;
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(_halfWidth-width/2,y, width, height)];
    [_backBtn setTitle:@"我已有账号" forState:UIControlStateNormal];
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [_backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_backBtn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
    [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
}

-(BOOL)prefersStatusBarHidden{
    return YES;//隐藏为YES，显示为NO
}

#pragma mark - KeyBoard

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_accountTF isExclusiveTouch]) {
        [_accountTF resignFirstResponder];
    }
    if (![_passwordTF isExclusiveTouch]) {
        [_passwordTF resignFirstResponder];
    }
    if (![_nickNameTF isExclusiveTouch]) {
        [_nickNameTF resignFirstResponder];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [_accountTF resignFirstResponder];
        [_passwordTF resignFirstResponder];
        [_nickNameTF resignFirstResponder];
        return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    UITextField *next = theTextField;
    if(next == _nickNameTF){
        [_accountTF becomeFirstResponder];
    }
    if (next == _accountTF) {
        [_passwordTF becomeFirstResponder];
    }else if(next == _passwordTF){
        [self signUpBtnClickAV];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect curFrame = self.view.frame;
    if(textField == self.nickNameTF){
        curFrame.origin.y -= 10;
    }
    if(textField == self.accountTF){
        curFrame.origin.y -= 70;
    }
    if(textField == self.passwordTF){
        curFrame.origin.y -= 90;
    }
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame=curFrame;
    }];
}

-(void)viewWillAppear:(BOOL)animated{
//    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    CGRect curFrame = self.view.frame;
    if(textField == self.accountTF){
        if(!([MyPublic isPhoneNumber:_accountTF.text]||[MyPublic validateEmail:_accountTF.text])){
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"手机号 & 邮箱都可以哦" delegate:self cancelButtonTitle:@"好的 (=￣ω￣=)" otherButtonTitles: nil];
            [alertView show];
            [_accountTF becomeFirstResponder];
        }
        curFrame.origin.y += 70;
    }
    if(textField == self.passwordTF){
        if(self.passwordTF.text.length < 5){
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"密码要大于5位哦" delegate:self cancelButtonTitle:@"好的 (=￣ω￣=)" otherButtonTitles: nil];
            [alertView show];
            [_passwordTF becomeFirstResponder];
        }
        curFrame.origin.y += 90;
    }
    if(textField == self.nickNameTF){
        if(self.nickNameTF.text.length < 1){
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"要有昵称哦" delegate:self cancelButtonTitle:@"好的 (=￣ω￣=)" otherButtonTitles: nil];
            [alertView show];
            [_nickNameTF becomeFirstResponder];
        }
        curFrame.origin.y += 10;
    }
    [UIView animateWithDuration:0.2f animations:^{
        self.view.frame=curFrame;
    }];
}

#pragma mark - Action

-(void)cameraTouch{
    UIStoryboard *photo = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    PhotoStackViewController *photoStackVC = [photo instantiateViewControllerWithIdentifier:@"photoStack"];
    photoStackVC.delegate = self;
    [self presentViewController:photoStackVC animated:YES completion:nil];
}

-(void)backBtnClick{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)sendUserDictoServer:(NSDictionary *)userDic{
    NSString *URLRegister=[NSString stringWithFormat:@"%@register/",DEBUG_URL];
    _myPublic = [[MyPublic alloc]init];
    NSLog(@"%@",userDic);
    [_myPublic GET:URLRegister paramters:userDic success:^(NSDictionary *responseObject) {
        NSString *status = [responseObject objectForKey:@"Status"];
        if([status isEqualToString:@"OK"])
        {
            NSLog(@"成功发送至服务器");
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)addToUserDic:(NSString *)signUpType SetUser:(AVUser *)user{
    _accountType = signUpType;
    _userDic =[[NSDictionary alloc]initWithObjectsAndKeys:
               _nickNameTF.text,@"nick",
               _passwordTF.text,@"password",
               _accountTF.text,@"account",
               _avatarNum,@"avatarNum",
               user.sessionToken,@"token",
               user.objectId,@"userID",
               _accountType,@"accountType",nil
               ];
    if([signUpType  isEqual: @"1"]){
        ValidMobile *v = [[ValidMobile alloc] init];
        v.userDic = _userDic;
        [self.navigationController pushViewController:v animated:YES];
    }else if([signUpType  isEqual: @"2"]){
        [self sendUserDictoServer:_userDic]; 
    }
}

-(void)signUpBtnClickAV{
    AVUser *user = [AVUser user];
    user.password = _passwordTF.text;
    user.username = _nickNameTF.text;
//    user.nickname = _nickNameTF.text;
    if([MyPublic isPhoneNumber:_accountTF.text]){
        user.mobilePhoneNumber = _accountTF.text;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                [self addToUserDic:@"1" SetUser:user];                                   //mobile
            }
            else{
                UIAlertView *fail = [[UIAlertView alloc]initWithTitle:@"" message:@"账户名已存在哦" delegate:self cancelButtonTitle:@"好的 (=￣ω￣=)" otherButtonTitles:nil, nil];
                [fail show];
                [_accountTF becomeFirstResponder];
            }
        }];
    }else if([MyPublic validateEmail:_accountTF.text]){
        user.email = _accountTF.text;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self addToUserDic:@"2" SetUser:user];
                [self dismissViewControllerAnimated:YES completion:nil];
                //email
            } else {
                UIAlertView *fail = [[UIAlertView alloc]initWithTitle:@"" message:@"账户名已存在哦" delegate:self cancelButtonTitle:@"好的 (=￣ω￣=)" otherButtonTitles:nil, nil];
                [fail show];
                [_accountTF becomeFirstResponder];
            }
        }];
    }else{
        UIAlertView *fail = [[UIAlertView alloc]initWithTitle:@"" message:@"请用邮箱或手机哦" delegate:self cancelButtonTitle:@"好的 (=￣ω￣=)" otherButtonTitles:nil, nil];
        [fail show];
        [_accountTF becomeFirstResponder];
    }
}


#pragma mark - Avatar
-(NSUInteger) photoSelectedIndex:(NSUInteger)index{
    NSLog(@"%ld",index);
    [_cameraImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"a%ld.jpg",(NSInteger)index+1]]];
    _avatarNum = [NSString stringWithFormat:@"%ld",index+1];
    return index;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(![_cameraImg isExclusiveTouch]){
        [_cameraImg setAlpha:0.8];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(![_cameraImg isExclusiveTouch]){
        [_cameraImg setAlpha:1.0];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if(![_cameraImg isExclusiveTouch]){
        [_cameraImg setAlpha:1.0];
    }
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// returns the # of rows in each component..

@end
