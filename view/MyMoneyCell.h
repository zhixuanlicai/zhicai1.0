//
//  myMoneyCell.h
//  zhicai
//
//  Created by perfect on 15/4/1.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myMoneyModel.h"
@interface MyMoneyCell : UITableViewCell
{

    
    UIImageView * image;
    UIView * lView;//线条
  //  UILabel * cLab;

}
@property(nonatomic,strong)UILabel * cLab;
- (void)configModel:(myMoneyModel *)model;

@end
