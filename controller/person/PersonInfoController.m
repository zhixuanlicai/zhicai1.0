//
//  personInfoController.m
//  zhicai
//
//  Created by perfect on 15/4/8.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "PersonInfoController.h"
#import "ChangeBankController.h"
#import "ChangePwdController.h"
@interface PersonInfoController ()

@end

@implementation PersonInfoController

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
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"个人信息"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
    
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    [navView addSubview:backBtn];
    
}

- (void)createView
{

    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 84, MRScreenWidth, 132)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //账户
    UILabel * lab1 = [MyControl createLabelFrame:CGRectMake(16, 0, 100, 44) font:15 Text:@"账户"];
    lab1.textColor = [MyControl getColor:@"#31424A"];
    [view addSubview:lab1];
    
    UILabel * lab2 = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-120, 0, 120, 44) font:15 Text:[NSString stringWithFormat:@"%@",gAppDelegate.userModel.mobilePhone]];
    lab2.textColor = [MyControl getColor:@"#8F8F8F"];
    [view addSubview:lab2];
    lab2.textAlignment = NSTextAlignmentRight;
    //lab2.backgroundColor = [UIColor redColor];
    
    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake(16, 43, MRScreenWidth-33, 1)];
    lineView1.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [view addSubview:lineView1];
    
    
    //姓名
    UILabel * lab3 = [MyControl createLabelFrame:CGRectMake(16, 44, 100, 44) font:15 Text:@"姓名"];
    lab3.textColor = [MyControl getColor:@"#31424A"];
    [view addSubview:lab3];
    
    UILabel * lab4 = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-120, 44, 120, 44) font:15 Text:[NSString stringWithFormat:@"%@",gAppDelegate.userModel.userName]];
    lab4.textColor = [MyControl getColor:@"#8F8F8F"];
    lab4.textAlignment = NSTextAlignmentRight;
    [view addSubview:lab4];
    //lab4.backgroundColor = [UIColor greenColor];
    
    UIView * lineView2 = [[UIView alloc]initWithFrame:CGRectMake(16, 87, MRScreenWidth-32, 1)];
    lineView2.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [view addSubview:lineView2];
    
    
   // 身份证号
    UILabel * lab5 = [MyControl createLabelFrame:CGRectMake(16, 88, 100, 44) font:15 Text:@"身份证号"];
    lab5.textColor = [MyControl getColor:@"#31424A"];
    [view addSubview:lab5];
    
    UILabel * lab6 = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-200, 88, 200, 44) font:15 Text:[NSString stringWithFormat:@"%@",gAppDelegate.userModel.userOther.idcardNum]];
    lab6.textColor = [MyControl getColor:@"#8F8F8F"];
    lab6.textAlignment = NSTextAlignmentRight;
    [view addSubview:lab6];
  //  lab6.backgroundColor = [UIColor purpleColor];
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 236, MRScreenWidth, 88)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    
    UIButton * pwdBtn = [MyControl createButtonFrame:CGRectMake(0, 0, MRScreenWidth, 44) Title:nil BgImageName:nil ImageName:nil Method:@selector(pwdClick) target:self];
    [view2 addSubview:pwdBtn];
    
    UILabel * lab7 = [MyControl createLabelFrame:CGRectMake(16, 0, 100, 44) font:15 Text:@"密码管理"];
    lab7.textColor = [MyControl getColor:@"#31424A"];
    [pwdBtn addSubview:lab7];
    
    UIImageView * img1 = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, (44-11)/2, 7, 11) imageName:@"dxiayib@1x.png"];
    //img.backgroundColor = [UIColor purpleColor];
    [pwdBtn addSubview:img1];
    
    
    UIView * lineView3 = [[UIView alloc]initWithFrame:CGRectMake(16, 43, MRScreenWidth-32, 1)];
    lineView3.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [view2 addSubview:lineView3];
    
    
    UIButton * bankBtn = [MyControl createButtonFrame:CGRectMake(0, 44, MRScreenWidth, 44) Title:nil BgImageName:nil ImageName:nil Method:@selector(bankClick) target:self];
    [view2 addSubview:bankBtn];
    
    UILabel * lab8 = [MyControl createLabelFrame:CGRectMake(16, 0, 100, 44) font:15 Text:@"银行卡管理"];
    lab8.textColor = [MyControl getColor:@"#31424A"];
    [bankBtn addSubview:lab8];
    
    UIImageView * img2 = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, (44-11)/2, 7, 11) imageName:@"dxiayib@1x.png"];
    [bankBtn addSubview:img2];
    
    
    
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)pwdClick
{

    NSLog(@"密码管理");
    ChangePwdController * pwd = [[ChangePwdController alloc]init];
    [self.navigationController pushViewController:pwd animated:YES];
    

}

- (void)bankClick
{


    NSLog(@"银行卡管理");
    ChangeBankController * bank = [[ChangeBankController alloc]init];
    [self.navigationController pushViewController:bank animated:YES];

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
