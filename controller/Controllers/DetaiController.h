//
//  DetaiController.h
//  zhicai
//
//  Created by perfect on 15/4/2.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "HomeModel.h"
#import "productModel.h"
#import <UIKit/UIKit.h>

@interface DetaiController : UIViewController
{
    BOOL refreshing;
    UIView * headView;//头部view
    UIView * footView;// 尾部view
    NSString * strTime;
    UILabel * tLab;//期限
    UILabel * personLab;//人数
    UILabel * glab;//年化收益
    UILabel * canLab;
    UILabel * yLab;
    UILabel * lab2;
}

@property(nonatomic,strong) productModel* promodel;
@property(nonatomic,strong) HomeModel* homemodel;
@property(nonatomic,assign)BOOL isSalevc;
@property(nonatomic,strong)UILabel * navlab;
@property(nonatomic,strong)UILabel * tLab;
@property(nonatomic,strong)UILabel * personLab;
@property(nonatomic,strong)UILabel * glab;
@property(nonatomic,strong)UILabel * canLab;
@end
