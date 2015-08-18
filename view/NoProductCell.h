//
//  noProductCell.h
//  zhicai
//
//  Created by perfect on 15/4/1.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"//圆环
#import "productModel.h"
@interface NoProductCell : UITableViewCell
{
     UILabel * lab2;//第二行lab
    
    UILabel * lab6;//第三行lab 百分号

    // 第二列
    
    UILabel * lab5;//第二行lab
    
    UIView * lineView;//线条
}
@property(nonatomic,strong)UILabel * lab1;//第一行lab
@property(nonatomic,strong)UILabel * lab3;//第三行lab
@property(nonatomic,strong)UILabel * lab4;//第一行lab
@property(nonatomic,strong)ProgressView * proView;//圆环
- (void)configModel:(productModel *)model;

@end
