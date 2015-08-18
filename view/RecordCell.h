//
//  recordCell.h
//  zhicai
//
//  Created by perfect on 15/4/9.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "recordModel.h"
#import <UIKit/UIKit.h>

@interface RecordCell : UITableViewCell
{

    UIImageView * recordImg;
   
}
@property(nonatomic,strong)recordModel* model;
@property(nonatomic,strong)UILabel * infoLab;
@property(nonatomic,strong)UILabel * priceLab;
@property(nonatomic,strong) UILabel * timeLab;
-(void)setmodel:(recordModel*)recordmodel;
@end
