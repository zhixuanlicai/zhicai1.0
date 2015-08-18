//
//  addBankController.m
//  zhicai
//
//  Created by perfect on 15/4/7.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "AddBankController.h"
#import "AddBankView.h"

@interface AddBankController ()

@end

@implementation AddBankController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNav];
    [self createView];
}
- (void)createNav
{
    self.view.backgroundColor = [MyControl getColor:@"EDEDED"];
    self.navigationController.navigationBarHidden = YES;
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"选择银行卡"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
    
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    // backBtn.backgroundColor = [UIColor redColor];
    [navView addSubview:backBtn];
    
}
- (void)createView
{
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.backgroundColor = [UIColor whiteColor];
    addBtn.frame = CGRectMake(0, 80, MRScreenWidth, 44);
    [addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    UIImageView * addImg = [MyControl createImageViewFrame:CGRectMake(16, (40-23)/2+2, 23, 23) imageName:@"tianjiayhk@1x.png"];
    [addBtn addSubview:addImg];
    
    UILabel * addLab= [MyControl createLabelFrame:CGRectMake(55, 0, 100,44) font:15 Text:@"添加银行卡"];
    [addBtn addSubview:addLab];
    
    UIImageView * img = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, (44-11)/2+3, 7, 11) imageName:@"dxiayib@1x.png"];
    [addBtn addSubview:img];
    
}


- (void)addClick
{

    AddBankView * add = [[AddBankView alloc]init];
    [self.navigationController pushViewController:add animated:YES];


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
