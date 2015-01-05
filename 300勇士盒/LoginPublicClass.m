//
//  LoginPublicClass.m
//  SportMan
//
//  Created by Yeti on 16/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "LoginPublicClass.h"
#import "MyPublic.h"

@interface LoginPublicClass ()

@end

@implementation LoginPublicClass

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)getCleanToken:(NSString *)token{
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    return token;
}

-(NSString *)getOutOfSpace:(NSString *)string{
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return  string;
}

- (NSMutableDictionary *)loginVarificationWithAccountText:(NSString *)account andPasswordText:(NSString *)passWord{
    NSString *alert = @"1";
    NSString *flag = @"1";
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc]init];
    
    if(passWord != nil){
        if([passWord length]==0){
            alert = @"密码不能为空";
            flag = @"3";
        }
    }else if([passWord length]<4){
        alert = @"密码必须大于4位";
        flag = @"3";
    }
    
    if([account  isEqual: @""]){
        alert = @"邮箱不能为空";
        flag = @"2";
    }else if(![MyPublic validateEmail:account]){
        alert = @"邮箱格式不正确";
        flag = @"2";
    }
    [resultDic setObject:@"0" forKey:@"valid_filed"];
    [resultDic setObject:flag forKey:@"TFflag"];
    [resultDic setObject:alert forKey:@"alert"];
    [resultDic setObject:account forKey:@"account"];
    [resultDic setObject:passWord forKey:@"passWord"];
    return resultDic;
}

- (NSMutableDictionary *)signUpVarificationWithAccountText:(NSString *)account PasswordText:(NSString *)passWord NickName:(NSString *)nickName{
    NSString *alert = @"1";
    NSString *flagTF = @"0";
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc]init];

    account = [self getOutOfSpace:account];
    passWord = [self getOutOfSpace:passWord];
    nickName = [self getOutOfSpace:nickName];
    
    if(![passWord isEqual: @""]){
        if([passWord length]<5){
            alert = @"密码必须大于5位";
            flagTF = @"3";
        }
    }
    else{
        alert = @"密码不能为空";
        flagTF = @"3";
    }
    
    if(![account isEqual: @""]){
        if(![MyPublic validateEmail:account]){
            alert = @"邮箱格式不正确";
            flagTF = @"2";
        }
    }
    else{
        alert = @"邮箱不能为空";
        flagTF = @"2";
    }
    
    if(![nickName isEqual: @""]){
        if([nickName length]<1){
            alert = @"昵称不得少于2位";
            flagTF = @"1";
        }
    }
    else{
        alert = @"你还没有填昵称哦";
        flagTF = @"1";
    }
    
    [resultDic setObject:alert forKey:@"alert"];
    [resultDic setObject:flagTF forKey:@"flagTF"];
    
    return resultDic;
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
