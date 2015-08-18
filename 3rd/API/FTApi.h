//
//  FTApi.h
//  libFT
//
//  Created by huoding on 14-4-9.
//  Copyright (c) 2014年 HuoDing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//#define API_BASE_URL @"http://192.168.0.100:8080/tnloan2/getview/app/u/"

//http://192.168.2.54/xampp/a.php
#define API_BASE_URL @"http://www.3renwx.com.cn/LC/"//外网

#define API_TM @"tm.php" //特卖
#define API_Login @"login.php"//登录
#define API_CoreConnect @"CoreMoreConnect.php"//联系我们
#define API_CoreSet @"CoreMoreSet.php"// 设置
#define API_CoreMore @"CorepMore.php"//更多
#define API_Corep @"corp2.php"//产品
#define API_Forget @"forget.php"// 忘记密码
#define API_Forgetnext @"forgetNext.php"// 忘记密码下一步
#define API_MyZC @"MyZC.php"// 我的资产
#define API_MyZCDetail @"MyZCDetail.php"// 我的资产详情
#define API_Product @"Product.php"// 理财产品
#define API_ProductRecDetail @"productRecDetail.php"//交易记录详情
#define API_ProductRecord @"ProductRecord.php"// 交易记录
#define API_Register @"register.php"// 注册
#define API_RegisterNext @"registerNext.php"// 注册下一步
#define API_PersonInfo @"PersonInfo.php"// 个人信息



//文件信息类
@interface FTUploadFile : NSObject
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *fileName;
@property (nonatomic,retain) NSString *mineType;
@property (nonatomic,retain) NSData *fileData;
@end

typedef enum
{
    FTJson     = 0,
    FTXml      = 1,
    FTPlist    = 2,
    FTImage    = 3,
    FTData     = 4
}FTFormat;

/*
 网络API请求类
 */

@interface FTApi : NSObject


@property (readonly, nonatomic, strong) NSString *restURL;
@property (readonly, nonatomic, unsafe_unretained) FTFormat format; //json ,xml,data,text,image,plist

+ (instancetype)APIWithURL:(NSString*)url withFormat:(FTFormat)format;

+ (NSString*)getAppToken;

- (void)get:(NSDictionary*)params complate:(void (^)(id response,NSError *error))complete;
- (void)post:(NSDictionary*)params complate:(void (^)(id response,NSError *error))complete;
- (void)del:(NSDictionary*)params complate:(void (^)(id response,NSError *error))complete;
- (void)patch:(NSDictionary*)params complate:(void (^)(id response,NSError *error))complete;
- (void)put:(NSDictionary*)params complate:(void (^)(id response,NSError *error))complete;
- (void)post:(NSArray*)fileArr withParams:(NSDictionary*)params complete:(void (^)(id response,NSError *error))complate;

@end

@interface FTApi (helper)

+ (void)requestWithMethod:(NSString*)method withPath:(NSString*)path withParams:(NSDictionary*)params complate:(void (^)(id response,NSError *error))complete;

+ (void)requestWithPostFile:(NSArray*)file withPath:(NSString*)path withParams:(NSDictionary*)params complate:(void (^)(id response,NSError *error))complete;

+ (void)downloadWithUrl:(NSString*)url toFilePath:(NSString*)filePath  isContinue:(BOOL)isContinue withProgressBlock:(void (^)(long long downBytes,long long totalBytes))block complate:(void (^)(NSError *error))complete;

@end

