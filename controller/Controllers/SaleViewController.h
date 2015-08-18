//
//  saleViewController.h
//  zhicai
//
//  Created by perfect on 15/3/23.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "HomeModel.h"
#import <UIKit/UIKit.h>

@interface SaleViewController : UIViewController
@property(nonatomic,strong)HomeModel* homemodel;

@property(nonatomic,weak) UILabel *btnLab;
@end
