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
 *  获得用户的UserDefault
 *
 *  @return 字典形式返回用户的资料
 *  @return nil   空为未登录
 *  @return user(NSDictionary)  已登录
 */
- (NSDictionary *)GetUserModel;


@end
