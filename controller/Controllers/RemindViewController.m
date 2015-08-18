//
//  remindViewController.m
//  zhicai
//
//  Created by perfect on 15/3/25.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "RemindViewController.h"

@interface RemindViewController ()

@end

@implementation RemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
}
- (void)createNav
{
    
    self.navigationController.navigationBarHidden = YES;
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:self.titStr];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"010D12"];
    [self.view addSubview:navlab];
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 63, MRScreenWidth-30, 1)];
    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [self.view addSubview:lineView];
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    [self.view addSubview:backBtn];
    
}


- (void)backClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    self.parentViewController.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    
    self.parentViewController.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
