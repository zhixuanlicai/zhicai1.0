//
//  IsMortgageControllerViewController.h
//  zhicai
//
//  Created by MJP on 12/8/15.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "productModel.h"
#import "HomeModel.h"
@interface IsMortgageController : UIViewController


@property(nonatomic,strong) UILabel * navlab;
@property(nonatomic,strong) productModel* promodel;
@property(nonatomic,strong) HomeModel* homemodel;
@property(nonatomic,assign) BOOL isSalevc;
@property(nonatomic,strong) NSMutableArray *imageArr;

@end
