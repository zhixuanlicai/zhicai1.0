//
//  BankCardModel.h
//  zhicai
//
//  Created by 陈思思 on 15/7/28.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardModel : NSObject
@property(nonatomic,copy)NSString* logoPath;
@property(nonatomic,copy)NSString* cardname;
@property(nonatomic,copy)NSString* cardNum;
@property(nonatomic,copy)NSString* cardId;
@property(nonatomic,copy)NSString* credate;
@property(nonatomic,copy)NSString* moddate;
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,copy)NSString* bankName;
@end
/*
 bankid = 31;
 cardname = "";
 cardnum = 1111111111111111;
 carid = 201;
 credate = 20150728;
 moddate = "";
 pop1 = "";
 pop2 = "";
 userid = 18610;
 */