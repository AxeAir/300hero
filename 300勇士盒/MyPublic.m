//
//  MyPublic.m
//  SportMan
//
//  Created by Yeti on 4/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "MyPublic.h"
#import <AFHTTPRequestOperationManager.h>
#import "UConstants.h"



#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
@interface MyPublic()

@property (strong,nonatomic)NSMutableArray * maError;

@end


@implementation MyPublic

+ (NSString *)getNums:(NSString *)str{
    NSScanner *scanner = [NSScanner scannerWithString:str];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    NSInteger number;
    [scanner scanInteger:&number];
    NSLog(@"number:%ld", (long)number);
    return [NSString stringWithFormat:@"%ld",(long)number];
}

+ (BOOL)validateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL) isPhoneNumber:(NSString*) phonenumber{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //    /**
    //     15         * 中国联通：China Unicom
    //     16         * 130,131,132,152,155,156,185,186
    //     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //    /**
    //     20         * 中国电信：China Telecom
    //     21         * 133,1349,153,180,189
    //     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    //    /**
    //     25         * 大陆地区固话及小灵通
    //     26         * 区号：010,020,021,022,023,024,025,027,028,029
    //     27         * 号码：七位或八位
    //     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSString * PHS1 = @"^0(10|2[0-5789]|\\d{3}-)\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    NSPredicate *regextestphs1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS1];
    
    if (([regextestmobile evaluateWithObject:phonenumber] == YES)||
        ([regextestcm evaluateWithObject:phonenumber] == YES)||
        ([regextestct evaluateWithObject:phonenumber] == YES)||
        ([regextestcu evaluateWithObject:phonenumber] == YES)
        || ([regextestphs evaluateWithObject:phonenumber] == YES)
        || ([regextestphs1 evaluateWithObject:phonenumber] == YES)
        )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)LogError:(NSString *)szError{
    NSDateFormatter * formate = [[NSDateFormatter alloc] init];
    [formate setDateFormat:@"YYYYMMDDhhmmss"];
    NSString *szLog = [NSString stringWithFormat:@"%@ %@",[formate stringFromDate:[NSDate date]],szError ];
    _maError = [[NSMutableArray alloc] init];
    if (_maError.count > 10) {
        return;
    }
    [_maError addObject:szLog];
    
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    
    [userdefault setObject:_maError forKey:@"Error"];
    [userdefault synchronize];
}

- (BOOL)PostMsg:(NSString *)szURL WithSendDictionary:(NSDictionary *)dicSendMsg WithImg:(NSString *)imgPath WithImgKey:(NSString *)imgKeyName WithSuccess:(void (^)(NSDictionary * dicResult))WithSuccess
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    
    if(imgPath == nil){
        imgPath =@"";
    }
    
    AFHTTPRequestOperation *oper;
    NSLog(@"%@",szURL);
    oper = [manager POST:szURL parameters:dicSendMsg constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(![imgPath isEqual:@""]){
            if(![imgKeyName isEqual:@""]){
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:imgPath] name:imgKeyName error:nil];
            }
        }
    }
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             WithSuccess(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self LogError:[NSString stringWithFormat:@"Post failure URL:%@ content:%@ error:%@",szURL,dicSendMsg,error]];
             UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络好像有点问题" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             [alertView show];
         }
    ];
    if(oper == nil){
        [self LogError:[NSString stringWithFormat:@"Post return nil URL:%@ content:%@",szURL,dicSendMsg]];
        return false;
    }
    return true;
}

+ (void)PostImageWithSendDictionary:(NSDictionary *)dic WithImgData:(NSData *)imgData WithSuccess:(void (^)(id))succeed WithSendFail:(void (^)(NSError *))fail {
    
    NSString *URL=[NSString stringWithFormat:@"%@train/tips/addPic",DEBUG_URL];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    
    [manager POST:URL parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:imgData name:@"pictureUrl" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        succeed(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail(error);
    }];

    
}

- (void)POST:(NSString *)URL paramters:(NSDictionary *)paramters success:(void (^)(NSDictionary * responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    [manager POST:URL parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
}

- (void)GET:(NSString *)URL paramters:(NSDictionary *)paramters success:(void (^)(NSDictionary * responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
}

- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (NSDictionary *)GetUserModel
{
    NSUserDefaults *userdafault=[NSUserDefaults standardUserDefaults];
    return [userdafault objectForKey:@"userModel"];
}


@end



