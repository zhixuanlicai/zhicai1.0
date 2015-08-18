//
//  productModel.h
//  zhicai
//
//  Created by perfect on 15/4/17.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface productModel : NSObject
//@property(nonatomic,copy)NSString * bitAmount;
//@property(nonatomic,copy)NSString * bitId;




@property(nonatomic,copy)NSString * endDate;
@property(nonatomic,copy)NSString * finId;
@property(nonatomic,copy)NSString * finRate;
@property(nonatomic,copy)NSString * lastDateLong;
@property(nonatomic,copy)NSString * lateMountPresent;
@property(nonatomic,copy)NSString * proId;
@property(nonatomic,copy)NSString * proName;
@property(nonatomic,copy)NSString * soldPre;
@property(nonatomic,copy)NSString * startDate;
@property(nonatomic,copy)NSString * totalMount;
@property(nonatomic,copy)NSString * totalPre;
@property(nonatomic,copy)NSString * upedMount;
@property(nonatomic,copy)NSString * upedbuyer;
@property(nonatomic,strong)NSMutableArray *financingPicList;

//
//@property(nonatomic,copy)NSString * timeDay;
//@property(nonatomic,copy)NSString * insurce;
//@property(nonatomic,retain)NSString * done;
@end
/*
 endDate = 20151110;
 finId = 206;
 finRate = 7;
 lastDateLong = "-57260131200000";
 lateMountPresent = 100;
 proId = 2;
 proName = "\U6d4b\U8bd5\U4ea7\U54c12\U6807\U540d\U79f0";
 soldPre = 40;
 startDate = 20151010;
 totalMount = 40000;
 totalPre = 40;
 upedMount = 0;
 upedbuyer = 0;
 */