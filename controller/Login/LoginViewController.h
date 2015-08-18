//
//  loginViewController.h
//  zhicai
//
//  Created by perfect on 15/3/23.
//  Copyright (c) 2015年 perfect. All rights reserved.


#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (nonatomic, assign) BOOL isFromLogOut;
@property(nonatomic,strong)UIView * navView;
@property(nonatomic,copy) NSString *username;
@end
