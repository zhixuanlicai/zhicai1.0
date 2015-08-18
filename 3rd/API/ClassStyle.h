//
//  ClassStyle.h
//  RuiSi
//
//  Created by  yanguang on 3/5/14.
//  Copyright (c) 2014 yyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FTModel.h"
@interface ClassStyle : NSObject

@end



@interface HappinessList : NSObject
@property(nonatomic,retain) NSString * id;
@property(nonatomic,retain) NSString * img;
@property(nonatomic,retain) NSString * info;
@property(nonatomic,retain) NSString * lobel;
@property(nonatomic,retain) NSString * mid;
@property(nonatomic,retain) NSString * phone;
@property(nonatomic,retain) NSString * sorts;
@property(nonatomic,retain) NSString * time;
@property(nonatomic,retain) NSString * title;
@property(nonatomic,retain) NSString * uid;
@property(nonatomic,retain) NSString * files;
@property(nonatomic,retain) NSString * width;
@property(nonatomic,retain) NSString * height;

@end

@interface HomeList : NSObject
@property(nonatomic,retain) NSString * del;
@property(nonatomic,retain) NSString * fid;
@property(nonatomic,retain) NSString * icon;
@property(nonatomic,retain) NSString * id;
@property(nonatomic,retain) NSString * img;
@property(nonatomic,retain) NSString * kid;
@property(nonatomic,retain) NSString * module;
@property(nonatomic,retain) NSString * name;
@property(nonatomic,retain) NSString * sorts;
@property(nonatomic,retain) NSString * statue;
@property(nonatomic,retain) NSString * token;
@property(nonatomic,retain) NSString * url;
@property(nonatomic,retain) NSString * yanse;
@property(nonatomic,retain) NSArray * sub;
@property(nonatomic,retain) NSString * classid;

@end

@interface ListContent : NSObject
@property(nonatomic,retain) NSString * classid;
@property(nonatomic,retain) NSString * classname;
@property(nonatomic,retain) NSString * click;
@property(nonatomic,retain) NSString * createtime;
@property(nonatomic,retain) NSString * id;
@property(nonatomic,retain) NSString * info;
@property(nonatomic,retain) NSString * keyword;
@property(nonatomic,retain) NSString * pic;
@property(nonatomic,retain) NSString * showpic;
@property(nonatomic,retain) NSString * sorts;
@property(nonatomic,retain) NSString * text;
@property(nonatomic,retain) NSString * title;
@property(nonatomic,retain) NSString * token;
@property(nonatomic,retain) NSString * type;
@property(nonatomic,retain) NSString * uid;
@property(nonatomic,retain) NSString * uname;
@property(nonatomic,retain) NSString * uptatetime;
@property(nonatomic,retain) NSString * url;
@property(nonatomic,retain) NSString * cover;
@property(nonatomic,retain) NSString * files;
@property(nonatomic,retain) NSString * name;
@property(nonatomic,retain) NSString * xtid;

@end

@interface PhotoList: NSObject
@property(nonatomic,retain) NSString * create_time;
@property(nonatomic,retain) NSString * id;
@property(nonatomic,retain) NSString * isshoinfo;
@property(nonatomic,retain) NSString * info;
@property(nonatomic,retain) NSString * kid;
@property(nonatomic,retain) NSString * num;
@property(nonatomic,retain) NSString * picurl;
@property(nonatomic,retain) NSString * title;
@property(nonatomic,retain) NSString * uptatetime;
@property(nonatomic,retain) NSString * token;
@property(nonatomic,retain) NSString * pid;
@property(nonatomic,retain) NSString * sort;
@property(nonatomic,retain) NSString * status;
@property(nonatomic,retain) NSString * cover;

@end

@interface HappinessRecord: NSObject
@property(nonatomic,retain) NSString * style; //类型 ：text,image,audio,vedio
@property(nonatomic,retain) NSString * hid;   //id
@property(nonatomic,retain) NSString * info;  //title
@property(nonatomic,retain) NSString * pic;   // 照片
@property(nonatomic,retain) NSString * kid;   //
@property(nonatomic,retain) NSString * img;   //dizhi
@property(nonatomic,retain) UIImage *  urlimg;   //
@property(nonatomic,retain) NSString * id;
@property(nonatomic,retain) NSString * lobel;
@property(nonatomic,retain) NSString * mid;
@property(nonatomic,retain) NSString * phone;
@property(nonatomic,retain) NSString * sorts;
@property(nonatomic,retain) NSString * imgtime;
@property(nonatomic,retain) NSString * title;
@property(nonatomic,retain) NSString * uid;
@property(nonatomic,retain) NSString * files;
@property(nonatomic,retain) NSString * width;
@property(nonatomic,retain) NSString * height;
@property(nonatomic,retain) NSString * com_count;   //该图片被多少人评论
@property(nonatomic,retain) NSString * col_count;   //该图片被多少人关注
@property(nonatomic,retain) NSString * is_collect;  //是否关注
@property(nonatomic,retain) NSString * qiniu_key;
@property(nonatomic,retain) NSString * cc;
@property(nonatomic,assign) BOOL isEdit;

@property(nonatomic,copy)NSString * is_sj;
@property(nonatomic,copy)NSString * is_wedding;
@property(nonatomic,copy)NSString * wid;
@property(nonatomic,retain) NSString * asset_url;

//@property(nonatomic,retain) NSString * com_count;
@property(nonatomic,retain) NSString * imgcom;
@property(nonatomic,retain) NSString * imgcollect;
@property(nonatomic,retain) NSString * Status;
@end

//我的喜帖
@interface MyWeddingCardModel : NSObject
@property(nonatomic,retain) NSString * Tag;         //封面图片
@property(nonatomic,retain) NSString * address;     //地址
@property(nonatomic,retain) NSString * bg_mp3;      //背景音
@property(nonatomic,retain) NSString * copyright;   //喜帖所属版权
@property(nonatomic,retain) NSString * head_xl;     //新郎头像
@property(nonatomic,retain) NSString * head_xn;     //新娘头像
@property(nonatomic,retain) NSString * hua;         //想说的话
@property(nonatomic,retain) NSString * id;          //我的喜帖的id
@property(nonatomic,retain) NSString * is_show;     //喜帖是否显示（你不用管）
@property(nonatomic,retain) NSString * keyword;     //关键字
@property(nonatomic,retain) NSString * latitude;    //经度
@property(nonatomic,retain) NSString * longitude;   //纬度
@property(nonatomic,retain) NSString * name_xl;     //新郎名字
@property(nonatomic,retain) NSString * name_xn;     //新娘名字
@property(nonatomic,retain) NSString * pic;         //合照
@property(nonatomic,retain) NSArray  * pic1;        //喜帖相册
@property(nonatomic,retain) NSString * pic2;        //无用的字段（忽略）
@property(nonatomic,retain) NSString * pwd_xr;      //权限密码
@property(nonatomic,retain) NSString * replypicurl; //回复图片
@property(nonatomic,retain) NSString * taxis;       //喜帖显示顺序（你不用管）
@property(nonatomic,retain) NSString * tel;         //新郎电话
@property(nonatomic,retain) NSString * tel_xn;      //新娘电话
@property(nonatomic,retain) NSString * time;        //宴会时间
@property(nonatomic,retain) NSString * title;       //喜帖名称
@property(nonatomic,retain) NSString * token;       //token值
@property(nonatomic,retain) NSString * video;       //视频链接
@property(nonatomic,retain) NSString * wx_name;     //用户手机
@property(nonatomic,retain) NSString * xt_tplid;    //喜帖模板id
@property(nonatomic,retain) NSString * xt_tplname;  //喜帖模板的名字（如：6_index）

@end

//留言展示
@interface MessageShowModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *picImgViewStr;
@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, copy) NSString *messageStr;
@property (nonatomic, copy) NSString *videoStr;
@end

//送祝福
@interface WishHappinessModel : NSObject

@property (nonatomic, copy) NSString *content;  //祝福内容
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSArray *huifu;//回复列表
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *pic;  //图片
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *time; //时间
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userName; //祝福人的名字
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *video;

@end



@interface EditChooseModel : NSObject
@property(nonatomic, copy) NSString * content;
@property(nonatomic, copy) NSString * count;
@property(nonatomic, copy) NSString * huifu;
@property(nonatomic, copy) NSString * lobel;
@property(nonatomic, copy) NSString * mid;
@property(nonatomic, copy) NSString * phone;
@property(nonatomic, copy) NSString * sorts;
@property(nonatomic, copy) NSString * time;
@property(nonatomic, copy) NSString * title;
@property(nonatomic, copy) NSString * uid;
@property(nonatomic, copy) NSString * files;
@property(nonatomic, copy) NSString * width;
@property(nonatomic, copy) NSString * height;
@end


//图片评论列表
@interface ImgCommentList : NSObject
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * imgid;
@property(nonatomic,copy)NSString * uid;
@property(nonatomic,copy)NSString * img;

@property(nonatomic,copy)NSString * isComment;
@property(nonatomic,copy)NSString * mytime;
@property(nonatomic,copy)NSString * usericon;
@property(nonatomic,copy)NSString * username;

@property(nonatomic,copy)NSString * is_sj;
@property(nonatomic,copy)NSString * is_wedding;
@property(nonatomic,copy)NSString * phone;
@property(nonatomic,copy)NSString * wid;

+ (NSDictionary *)configInputMap;
@end


//小工具 - 桌位宾客
@interface EveryDeskDetailModel : NSObject
@property (nonatomic, copy) NSString *numStr;
@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *mobileStr;
@end



@interface WeddingModel : NSObject
@property(nonatomic,copy)NSString * missucolor;   //(想你）颜色
@property(nonatomic,copy)NSString * titleimg;        //（幸福标题）颜色
@property(nonatomic,copy)NSString * dayscolor;    //（我们在一起多少天）颜色
@property(nonatomic,copy)NSString * celldaycolor; // (cell中的天数提醒，我们在一起21天)颜色
@property(nonatomic,copy)NSString * linecolor;    //（中间分割线的颜色；两框；圆点）颜色
@property(nonatomic,copy)NSString * groupcolor;   //（我们在一起1314天，名字）  颜色（黑或者白）
@property(nonatomic,copy)NSString * coverimg;
@property(nonatomic,copy)NSString * homeimg;
@property(nonatomic,copy)NSString * listimg;
@property(nonatomic,copy)NSString * detailsimg;
@property(nonatomic,copy)NSString * covertitle;
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * mobanid;

@end


@interface HappinessRecordList :NSObject
@property(nonatomic,copy)NSString * datetime;
@property(nonatomic,copy)NSString * describe;
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * lid;
@property(nonatomic,copy)NSString * src;
@property(nonatomic,copy)NSString * time;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * style;
@property(nonatomic,copy)NSString * timebq;
@property(nonatomic,copy)NSString * Status;

@end

@interface HappinessGroupFollowList :NSObject
@property(nonatomic,copy)NSString * bgmusicname;
@property(nonatomic,copy)NSString * groupphoto;
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * moban;
@property(nonatomic,copy)NSString * music;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * name1;
@property(nonatomic,copy)NSString * phone;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * time;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * token;
@property(nonatomic,copy)NSString * uidphone;
@property(nonatomic,copy)NSString * weddingtime;

@property(nonatomic,copy)NSString * imgid;
@property(nonatomic,copy)NSString * sjimg;
@property(nonatomic,copy)NSString * suiji;
@property(nonatomic,copy)NSString * uid;

@property(nonatomic,copy)NSString * col_count;
@property(nonatomic,copy)NSString * fm_img;
@property(nonatomic,copy)NSString * headimg;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * xid;
@property(nonatomic,copy)NSString * is_collect;

@end

