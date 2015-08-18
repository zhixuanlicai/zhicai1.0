//
//  addBankView.h
//  zhicai
//
//  Created by perfect on 15/4/7.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "BankCardModel.h"
#import "BankModel.h"
#import <UIKit/UIKit.h>
@protocol delegate <NSObject>

-(void)passModel:(BankModel*) bankmodel;

@end

@interface AddBankView : UIViewController
@property(nonatomic,retain)id<delegate>passmodel;
@property(nonatomic,strong)UILabel * bank;
@property(nonatomic,strong)NSString* bankid;
@property(nonatomic,strong)BankCardModel* mybankcarkmodel;


@end
