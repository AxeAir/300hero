//
//  LoginPublicClass.h
//  SportMan
//
//  Created by Yeti on 16/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginPublicClass : UINavigationController

/* By Yeti
 * 去掉 token 中的特殊符号
 * @param token
 */
- (NSString *)getCleanToken:(NSString *)token;

/* By Yeti
 * 登录验证
 * @param account,passWord
 */
- (NSMutableDictionary *)loginVarificationWithAccountText:(NSString *)account andPasswordText:(NSString *)password;

/* By Yeti
 * 注册验证
 * @param account,passWord
 */
- (NSMutableDictionary *)signUpVarificationWithAccountText:(NSString *)account PasswordText:(NSString *)passWord NickName:(NSString *)NickName;

@end
