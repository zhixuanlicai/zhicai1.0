//
//  bankCell.h
//  zhicai
//
//  Created by perfect on 15/4/8.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface BankCell : UITableViewCell
{
    UIImageView * bankImg;
    UILabel * bankLab;
    UILabel * haoLab;
}

-(void)setBank:(BankCardModel*) model;
@end
