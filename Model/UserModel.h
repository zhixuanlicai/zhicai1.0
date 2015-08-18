//
//  UserModel.h
//  zhicai
//
//  Created by 陈思思 on 15/7/24.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "UserOther.h"
#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property(nonatomic,copy)NSString* bitState;
@property(nonatomic,copy)NSString* boundImei;
@property(nonatomic,copy)NSString* channelKey;
@property(nonatomic,copy)NSString* creTime;
@property(nonatomic,copy)NSString* email;
@property(nonatomic,copy)NSString* emailPwd;
@property(nonatomic,copy)NSString* failureLoginCount;
@property(nonatomic,copy)NSString* imageName;
@property(nonatomic,copy)NSString* isactivation;
@property(nonatomic,copy)NSString* mobilePhone;
@property(nonatomic,copy)NSString* modperson;
@property(nonatomic,copy)NSString* modtime;
@property(nonatomic,copy)NSString* mpLoginCount;
@property(nonatomic,copy)NSString* orderno;
@property(nonatomic,copy)NSString* pcLoginCount;
@property(nonatomic,copy)NSString* recordStatus;
@property(nonatomic,copy)NSString* regArea;
@property(nonatomic,copy)NSString* regCity;
@property(nonatomic,copy)NSString* regCountry;
@property(nonatomic,copy)NSString* regCounty;
@property(nonatomic,copy)NSString* regIp;
@property(nonatomic,copy)NSString* regIsp;
@property(nonatomic,copy)NSString* regLocation;
@property(nonatomic,copy)NSString* regProvince;
@property(nonatomic,copy)NSString* regSource;
@property(nonatomic,copy)NSString* remark;
@property(nonatomic,copy)NSString* lastDeviceImei;
@property(nonatomic,copy)NSString* sex;
@property(nonatomic,copy)NSString* tokenId;
@property(nonatomic,copy)NSString* userCode;
@property(nonatomic,copy)NSString* userId;
@property(nonatomic,copy)NSString* userName;
@property(nonatomic,strong)NSArray* cards;
@property(nonatomic,strong)UserOther* userOther;
/* {
 bitState = "";
 boundImei = "";
 cards =         (
 {
 bankName = "\U534e\U590f\U94f6\U884c";
 cardNum = 1111111111111111;
 },
  );
 channelKey = "";
 cretime = 20150723161837;
 email = "";
 emailPwd = "";
 failureLoginCount = 0;
 imageName = "";
 isactivation = 0;
 mobilephone = 18211030384;
 modperson = "";
 modtime = "";
 mpLoginCount = 80;
 orderno = "";
 pcLoginCount = "";
 recordStatus = 1;
 regArea = "";
 regCity = "";
 regCountry = "";
 regCounty = "";
 regIp = "";
 regIsp = "";
 regLocation = "";
 regProvince = "";
 regSource = "";
 remark = "";
 sex = "";
 tokenId = 57915fc092e0164004a076cdb959b0ac;
 userCode = 18211030384;
 userId = 18610;
 userName = "";
*/
@end
