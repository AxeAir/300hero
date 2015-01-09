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

@interface ValidMobile ()<UITextFieldDelegate,UITextInput,UITextFieldDelegate>

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
    
    if(ISIPHONE){
        UIImage*img =[UIImage imageNamed:@"loginBg"];
        UIImageView* bgview = [[UIImageView alloc]initWithImage:img];
        bgview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:bgview];
    }
    
    _halfWidth = self.view.frame.size.width/2;
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    _validTF = [[UITextField alloc] init];
    _validTF.placeholder = @" 你の验证码";
    _validTF.frame = CGRectMake(_halfWidth-width*9/10/2, height/20*2, width*9/10, height/20);
    _validTF.layer.cornerRadius = 3;
    _validTF.backgroundColor = [UIColor whiteColor];
    _validTF.keyboardType = UIKeyboardTypeNumberPad;
    _validTF.returnKeyType = UIReturnKeyNext;
    _validTF.delegate = self;
    _validTF.returnKeyType = UIReturnKeyJoin;
    [self.view addSubview:_validTF];
    
    //SignUpBtn
    
    _saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(_halfWidth-100,height/20*4, 200, 30)];
    [_saveBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:RGBACOLOR(255, 255, 255, 0.7) forState:UIControlStateNormal];
    _saveBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [_saveBtn setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    [_saveBtn addTarget:self action:@selector(signUpBtnClickAV) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveBtn];
    
    //Back

    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(_halfWidth-100,height/10*9, 200, 30)];
    [_backBtn setTitle:@"返 回" forState:UIControlStateNormal];
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_backBtn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
    [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(_validTF.text.length == 6){
        [UIView animateWithDuration:0.5 animations:^{
            [_saveBtn setTitleColor:RGBACOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
        } completion:^(BOOL finished) {;
            nil;
        }];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_validTF isExclusiveTouch]) {
        [_validTF resignFirstResponder];
    }
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
