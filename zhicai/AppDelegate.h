//
//  AppDelegate.h
//  zhicai
//
//  Created by perfect on 15/3/19.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "UserModel.h"
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) BOOL isLogin;
@property (strong, nonatomic) UserModel* userModel;

@end

