//
//  MyPublic.h
//  SportMan
//
//  Created by Yeti on 4/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#include <net/if.h>


#define WEAYHERCACHESECOUND 3600 //天气缓存时间

@interface MyPublic : NSObject


/** By:Yeti
 *  检测是否为电话号码
 *
 */
+ (BOOL) isPhoneNumber:(NSString*) phonenumber;


/** By:Yeti
 *  检测是否为邮箱
 *
 */
+ (BOOL)validateEmail:(NSString *)email;

/** By:Yeti
 *  POST请求可带一张图片
 *
 *  @param szURL         请求地址
 *  @param dicSendMsg    字典参数
 *  @imgPath             图片地址
 *  @imgKeyName          图片名称
 *  @param WithSuccess   成功返回 json: {'Status:OK', 'Result':用户唯一标识符uID}
 *  @
 **/
- (BOOL)PostMsg:(NSString *)szURL WithSendDictionary:(NSDictionary *)dicSendMsg WithImg:(NSString *)imgPath WithImgKey:(NSString *)imgKeyName WithSuccess:(void (^)(NSDictionary * dicResult))WithSuccess;

/**
 *  POST请求发送照片
 *
 *  @param dic     接口所需要的参数@{ 
 *                                  gps:图片所对应的坐标点
 *                                  sportID:图片对应的sportId和昵称 格式： 昵称+sportID 例如：jason20141012534
 *                                  pictureName:图片名称
 *                                  pictureID:图片id
 *                                  userID:用户ID
 *                                  timestamp:时间戳
 *                                }
 *  @param imgData 图片数据nsdata 类型
 *  @param succeed 返回成功时调用的函数块
 *  @param fail    发送失败时调用的函数块
 *
 */
+ (void)PostImageWithSendDictionary:(NSDictionary *)dic
                        WithImgData:(NSData *)imgData
                        WithSuccess:(void (^)(id responseObject))succeed
                       WithSendFail:(void (^)(NSError *error))fail;


/** By:Yeti
 *  字符串获得数字
 *
 *  @param str 字符串
 *  @return 抽离出的数字
 *  @
 **/
+ (NSString *)getNums:(NSString *)str;


/** By:Yeti
 *  验证字符串是否为邮箱
 *
 *  @param email    字符串
 *  @return true or false
 **/
+ (BOOL)validateEmail:(NSString *)email;

/** By:Yeti
 *
 *  @param szError
 *  @param paramters 字典参数
 *  @param success
 *  @
 **/
- (void)LogError:(NSString *)szError;


//2014年12月13日17:08:43 陈浩
/**
 *  POST请求
 *
 *  @param URL       请求地址
 *  @param paramters 字典参数
 *  @param success   成功返回block
 *  @param error     失败返回block
 */
- (void)POST:(NSString *)URL paramters:(NSDictionary *)paramters success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSError *error))failure;


/**
 *  GET请求
 *
 *  @param URL       请求地址
 *  @param paramters 字典参数
 *  @param success   成功返回block
 *  @param error     失败返回block
 */
- (void)GET:(NSString *)URL paramters:(NSDictionary *)paramters success:(void (^)(NSDictionary * responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获得天气结果//通过城市名查找天气
 *
 *  @param province 省
 *  @param city     城市
 *  @param district 县区
 *  @param success  成功回调
 *  @param failure  失败回调
 */
- (void)getWeatherWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district  success:(void (^)(NSDictionary * responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  通过经纬度获得天气
 *
 *  @param longitude 经度
 *  @param latitude  维度
 *  @param success   成功回调
 *  @param failure   失败回调
 */
- (void)getWeatherWithLongitude:(NSNumber *)longitude latitude:(NSNumber *)latitude success:(void (^)(NSDictionary * responseObject))success failure:(void (^)(NSError *error))failure;


/**
 *  通过经纬度获得天气
 *
 *  @param longitude 经度
 *  @param latitude  维度
 *  @param success   成功回调
 *  @param failure   失败回调
 */
- (void)getWeatherWithIPAddress:(NSString *)ip success:(void (^)(NSDictionary * responseObject))success failure:(void (^)(NSError *error))failure;


/**
 *  获取用户的内网IP地址
 *
 *  @return 返回字典
 字典格式：
 "en0/ipv4" = "192.168.1.114";
 "en0/ipv6" = "fe80::1478:b605:ea3b:f490";
 "lo0/ipv4" = "127.0.0.1";
 "lo0/ipv6" = "fe80::1";
 "pdp_ip0/ipv4" = "10.145.124.116";
 */
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

/**
 *  获得用户的公网IP地址
 *
 *  @param completion <#completion description#>
 */
+ (void)getWANIPAddressWithCompletion:(void(^)(NSString *IPAddress))completion;

/**
 *  获得用户的UserDefault
 *
 *  @return 字典形式返回用户的资料
 *  @return nil   空为未登录
 *  @return user(NSDictionary)  已登录
 */
- (NSDictionary *)GetUserModel;


@end
