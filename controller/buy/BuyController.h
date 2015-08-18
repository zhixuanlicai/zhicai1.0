//
//  buyController.h
//  zhicai
//
//  Created by perfect on 15/4/7.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "HomeModel.h"
#import "productModel.h"
#import "BankCardModel.h"
#import <UIKit/UIKit.h>

@interface BuyController : UIViewController
@property(nonatomic,strong)UILabel * haoLab;
@property(nonatomic,strong)UILabel * numLab;
@property(nonatomic,strong)BankCardModel* mybankcmodel;
@property(nonatomic,strong)NSString* bankname;
@property(nonatomic,strong)productModel* promodel;
@property(nonatomic,strong)HomeModel* homemodel;
@property(nonatomic,assign)BOOL isHomemodel;
@property(nonatomic,strong)NSMutableArray* mycardarr;
@property(nonatomic,strong)NSString* cardNO;

@end
