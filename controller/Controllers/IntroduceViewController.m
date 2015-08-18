//
//  introduceViewController.m
//  zhicai
//
//  Created by perfect on 15/3/24.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "MainTabBarController.h"
#import "IntroduceViewController.h"

@interface IntroduceViewController ()

@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString* url = [NSString stringWithFormat:@"u/userBitfinancingList?tokenId=%@",gAppDelegate.userModel.tokenId];
//    [Httptool getWithURL:url Params:nil Success:^(id json, HttpCode code) {
//        NSDictionary* dic = (NSDictionary* )json;
//        NSArray* arr =[dic objectForKey:@"data"];
//        for (NSDictionary* mydic in arr) {
//            NSLog(@"%@",[mydic objectForKey:@"finname"]);
//        }
//        NSLog(@"%@",[dic objectForKey:@"msg"]);
//    } Failure:^(NSError *error) {
//        
//    }];
    
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
}

- (void)createNav
{
    
    self.navigationController.navigationBarHidden = YES;
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:navView];

    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:[NSString stringWithFormat:@"公司介绍"]];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
//    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 63, MRScreenWidth-30, 1)];
//    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
//    [self.view addSubview:lineView];
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    [navView addSubview:backBtn];
    
}


- (void)backClick
{
    
//    MainTabBarController* maintabvc = [[MainTabBarController alloc]init];
//    [self.navigationController pushViewController:maintabvc animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    self.parentViewController.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    self.parentViewController.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    
    self.parentViewController.tabBarController.tabBar.hidden = NO;
}


@end
