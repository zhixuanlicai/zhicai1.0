//
//  HomeModel.h
//  zhicai
//
//  Created by 陈思思 on 15/7/30.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
@property(nonatomic,copy)NSString* bitLimit;
@property(nonatomic,copy)NSString* finid;
@property(nonatomic,copy)NSString* finname;
@property(nonatomic,copy)NSString* finrate;
@property(nonatomic,copy)NSString* soldPre;
@property(nonatomic,copy)NSString* totalPre;
@property(nonatomic,copy)NSString* updays;
@property(nonatomic,copy)NSString* upedbuyer;
@end
/*
 bitLimit = 0;
 finid = 401;
 finname = "\U667a\U9009\U5929\U4e0b1\U671f";
 finrate = "10.00";
 soldPre = 8000;
 totalPre = 8000;
 updays = 33;
*/