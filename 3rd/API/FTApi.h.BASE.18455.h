//
//  FTApi.h
//  libFT
//
//  Created by huoding on 14-4-9.
//  Copyright (c) 2014年 HuoDing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//#define API_BASE_URL @"http://cwedding.com/"//外网
//#define API_BASE_URL @"http://114.215.198.226/" //我的喜帖
#define API_BASE_URL @"http://nw.iwed.com/"
#define API_IMAGE_URL @"http://nw.iwed.com/"


#define API_HappinessList @"index.php?g=User&m=Pxfj&a=xfjdf" //幸福随记列表
#define API_URL_WeddingPhotoList @"index.php?g=User&m=Pxfj&a=weddingSel" //甜蜜婚照列表


#define API_URL_Reg    @"index.php?g=User&m=Port&a=reg"  //注册
#define API_URL_ForgetPW    @"index.php?g=User&m=Port&a=pwdrevise"//忘记密码

#define API_URL_IDCode @"smsapp.php/"
#define API_URL_ForgerPassWordIDCode @"smspwdapp.php/"




//Set
#define API_URL_UserInfo    @"index.php?g=User&m=Port&a=usersave"
#define API_URL_UserInfoFix @"index.php?g=User&m=Port&a=xfjsave"
#define API_URL_UserNameFix @"index.php?g=User&m=Port&a=userinfosave"
#define API_URL_UserBingding @"index.php?g=User&m=Port&a=binding"
#define API_URL_UserBingdingKnow @"index.php?g=User&m=Port&a=know"
#define API_URL_UserChangeModel  @"http://nw.iwed.com/index.php?g=User&m=Pxfj&a=xfjmoban"

#define API_URL_UserIcon @"index.php?g=User&m=Pxfj&a=head"




#define API_URL_LoveImgList @"index.php?g=User&m=Port&a=myimgcollect" //我关注图片的列表

#define API_URL_addLoveImg @"index.php?g=User&m=Port&a=imgcollect"  //添加关注的图片
#define API_URL_deletaImg  @"index.php?g=User&m=Port&a=delimgcollect" //删除关注de图片

#define API_URL_addLoveImgComment @"index.php?g=User&m=Port&a=imgcom" //添加图片的评论
#define API_URL_LoveImgCommentList @"index.php?g=User&m=Port&a=imgcomment" //图片评论列表


#define API_URL_UploadWeddingImg @"index.php?g=User&m=Pxfj&a=weddingImg" //上传婚照





#define API_URL_Money @"index.php?g=User&m=Ptool&a=costtime" 

#define API_URL_Login    @"index.php?g=User&m=Port&a=login" //登陆

//url 网页链接
#define API_URL_Res @"http://cwedding.com/index.php?g=Wap&m=Index&a=reg" //注册

#define API_URL_PassWord @"http://nw.iwed.com/index.php?g=Wap&m=Index&a=pwdf" //忘记密码


//share url
#define API_URL_ChangePW @"http://www.cwedding.com/index.php?g=User&m=Port&a=pwd"


//新娘团
#define API_URL_BrideRoll @"index.php?g=User&m=Forum&a=index"   //分类新娘团
#define API_URL_InfoAllBrideRoll @"index.php?g=User&m=Forum&a=forumList&digest=0"    //详情全部
#define API_URL_InfoCategoryBrideRoll @"index.php?g=User&m=Forum&a=forumList&digest=1"   //详情加精 参数id
#define API_URL_ReplyMessageBrideRoll @"index.php?g=User&m=Forum&a=repliesList"    //回复评论 楼主参数id


//喜帖
#define API_URL_ModelList @"index.php?g=User&m=Port&a=xtlist"  //模版列表
#define API_URL_Upload @"index.php?g=User&m=Port&a=xtadd" //上传喜帖，修改喜帖数据
#define API_URL_ScanUrl @"http://www.cwedding.com/index.php?g=Wap&m=Xitie&a=index" //浏览页面
#define API_URL_myWeddingCard @"index.php?g=User&m=Port&a=xtlistTure"  //我的喜帖
#define API_URL_changeWeddingModel @"index.php?g=User&m=Pxitie&a=xtmoban"//修改喜帖模板模板
#define API_URL_myWeddingCardDelete @"index.php?g=User&m=Port&a=xtdelete" //我的喜帖删除
//动态模板
#define API_URL_MessageShow @"index.php/?g=User&m=Pxfj&a=bless" //展示留言祝福

#define API_URL_WishHappiness @"index.php?g=User&m=Bless&a=blessList"//祝福借口 参数：用户电话phone



//排座位
#define API_URL_DeskList @"index.php?g=User&m=Rowseat&a=seatList" //桌位列表 参数是phone = 18632962939
#define API_URL_UpAndChangePeople @"index.php?g=User&m=Rowseat&a=addVisitor"//添加宾客
#define API_URL_EveryDeskInfo @"index.php?g=User&m=Rowseat&a=addSeat"//添加修改每个桌子的信息 修改的话带id
#define API_URL_DeletedDeskInfo @"index.php?g=User&m=Rowseat&a=delSeat"//删除桌子所有信息  参数：用户电话phone  桌号t_number
#define API_URL_EveryDeskPeopleShow @"index.php?g=User&m=Rowseat&a=index"//来宾的信息  参数：用户电话phone
#define API_URL_DeletedDeskPeopleShow @"index.php?g=User&m=Rowseat&a=delVisitor"//删除桌子来宾的信息  参数：用户电话phone  宾客id


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

