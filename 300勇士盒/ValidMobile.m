//
//  ValidMobile.m
//  300勇士盒
//
//  Created by Yeti on 3/1/15.
//  Copyright (c) 2015 xxTeam. All rights reserved.
//

#import "ValidMobile.h"
#import <AVUser.h>
#import "MyPublic.h"
#import "UConstants.h"
#import "SighUP.h"

@interface ValidMobile ()<UITextFieldDelegate>

@property (strong,nonatomic) SighUP *sighUp;
@property (strong,nonatomic) MyPublic *myPublic;
@property (strong,nonatomic) UIButton *saveBtn;
@property (strong,nonatomic) UIButton *backBtn;
@property (assign,nonatomic) NSString *alert;
@property (assign,nonatomic) UIAlertView *alertView;

//验证码
@property (strong,nonatomic) UIButton *sendPhoneNumBtn;
@property (strong,nonatomic) UITextField *validTF;
@property (strong,nonatomic) NSString *validStr;
@property (assign,nonatomic) CGFloat halfWidth;
@end

@implementation ValidMobile

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _halfWidth = self.view.frame.size.width/2;
    int width = 200;
    int height = 30;
    int space = 8;
    int y = 30;
    
    _validTF = [[UITextField alloc] init];
    _validTF.placeholder = @" 你の验证码";
    _validTF.frame = CGRectMake(_halfWidth-width/2, y, 130, height);
    _validTF.layer.cornerRadius = 3;
    _validTF.backgroundColor = [UIColor whiteColor];
    _validTF.keyboardType = UIKeyboardTypeNumberPad;
    _validTF.returnKeyType = UIReturnKeyNext;
    _validTF.delegate = self;
    _validTF.returnKeyType = UIReturnKeyJoin;
    [self.view addSubview:_validTF];
    
    //SignUpBtn
    width = 150;
    height = 30;
    y += height + space*8;
    _saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(_halfWidth-width/2,y, width, height)];
    [_saveBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor colorWithRed:0 green:1 blue:1 alpha:1] forState:UIControlStateNormal];
    _saveBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_saveBtn setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    [_saveBtn addTarget:self action:@selector(signUpBtnClickAV) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveBtn];
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if(theTextField == _validTF){
        [_saveBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
     if ([string isEqualToString:@"\n"]) {
         [_validTF resignFirstResponder];
         return NO;
     }
    return YES;
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

-(void)signUpBtnClickAV{
    if([_validTF.text length]==6){
        [AVUser verifyMobilePhone:_validTF.text withBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                NSLog(@"%@",_userDic);
                [self sendUserDictoServer:_userDic];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else{
                UIAlertView *alertView =
                [[UIAlertView alloc]initWithTitle:@"提示"
                                          message:@"验证码不正确"
                                         delegate:self
                                cancelButtonTitle:@"好的"
                                otherButtonTitles:nil, nil];
                [alertView show];
                NSLog(@"%@",error);
            }
        }];
    }else{
        UIAlertView *alertView =
        [[UIAlertView alloc]initWithTitle:@"提示"
                               message:@"验证码位数不对"
                              delegate:self
                     cancelButtonTitle:@"好的"
                     otherButtonTitles:nil, nil];
        [alertView show];
    }
}

-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
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
