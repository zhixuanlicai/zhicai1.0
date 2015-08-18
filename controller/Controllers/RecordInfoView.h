//
//  recordInfoView.h
//  zhicai
//
//  Created by perfect on 15/4/9.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "MyProductsListModel.h"
#import "recordModel.h"
#import <UIKit/UIKit.h>

@interface RecordInfoView : UIViewController
@property(nonatomic,strong) recordModel* recordmodel;
@property(nonatomic,strong) MyProductsListModel* myproList;
@property(nonatomic,copy)NSString* finId;
@end
