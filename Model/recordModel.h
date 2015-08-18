//
//  recordModel.h
//  zhicai
//
//  Created by perfect on 15/4/16.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface recordModel : NSObject

@property(nonatomic,copy)NSString* bitAmount;
@property(nonatomic,copy)NSString* bitId;
@property(nonatomic,copy)NSString* bitLimit;
@property(nonatomic,copy)NSString* bitprofit;
@property(nonatomic,copy)NSString* creDate;
@property(nonatomic,copy)NSString* endDate;
@property(nonatomic,copy)NSString* finId;
@property(nonatomic,copy)NSString* finname;
@property(nonatomic,copy)NSString* finrate;
@property(nonatomic,copy)NSString* isdelete;
@property(nonatomic,copy)NSString* isout;
@property(nonatomic,copy)NSString* issplit;
@property(nonatomic,copy)NSString* modDate;
@property(nonatomic,copy)NSString* proId;
@property(nonatomic,copy)NSString* profit;
@property(nonatomic,copy)NSString* splitFinId;
@property(nonatomic,copy)NSString* startDate;
@property(nonatomic,copy)NSString* totalMount;
@property(nonatomic,copy)NSString* userid;

/*
 bitAmount = 500;
 bitId = 3;
 bitLimit = 31;
 bitprofit = 6000;
 creDate = 20150901;
 endDate = 20150816;
 finId = 1;
 finname = "\U6d4b\U8bd5\U7406\U8d22\U4ea7\U54c1\U4e00\U671f";
 finrate = 12;
 isdelete = 0;
 isout = 0;
 issplit = 0;
 modDate = 20150901;
 proId = 1;
 profit = 60;
 splitFinId = 0;
 startDate = 20150716;
 totalMount = 5000;
 userid = 400;
 
 */


//@property(nonatomic,copy)NSString * id;
//@property(nonatomic,copy)NSString * tradeId;
//@property(nonatomic,copy)NSString * trade;
//@property(nonatomic,copy)NSString * tradeTit;
//@property(nonatomic,copy)NSString * benjin;
//@property(nonatomic,copy)NSString * detailTime;

@end
