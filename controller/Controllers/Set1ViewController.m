//
//  set1ViewController.m
//  zhicai
//
//  Created by perfect on 15/3/25.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "Set1ViewController.h"
#import "RemindViewController.h"
#import "AboutViewController.h"
@interface Set1ViewController ()
@end

@implementation Set1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor grayColor];
    
    UIBarButtonItem * backBtn = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.leftBarButtonItem.title = @"返回";
    self.navigationItem.title = @"设置";
    
    
     [self createView];
    
}

- (void)backClick
{

    [self.navigationController popViewControllerAnimated:YES];

}
- (void)createView
{

    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, MRScreenWidth, 80)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];

    UILabel * lab1 = [MyControl createLabelFrame:CGRectMake(5, 5, 100, 35) font:15 Text:@"新品上线提醒"];
    [bgView addSubview:lab1];
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(105, 5, MRScreenWidth-105, 35);
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor redColor];
    [bgView addSubview:btn1];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 42, MRScreenWidth, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    [bgView addSubview:lineView];
    
    UILabel * lab2 = [MyControl createLabelFrame:CGRectMake(5, 45, 100, 35) font:15 Text:@"关于智选理财"];
    [bgView addSubview:lab2];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(105, 46, MRScreenWidth-105, 35);
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor redColor];
    [bgView addSubview:btn2];
    
    
    
    UIButton * inLogin = [MyControl createButtonFrame:CGRectMake(0, MRScreenHeight-86, MRScreenWidth-20, 40) Title:@"登录" BgImageName:nil ImageName:nil Method:@selector(loginClick) target:self];
   
    inLogin.titleLabel.textAlignment = NSTextAlignmentCenter;
    [inLogin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    inLogin.titleLabel.font = [UIFont systemFontOfSize:15];
    inLogin.backgroundColor = [UIColor greenColor];
    [self.view addSubview:inLogin];
}
- (void)btn1Click
{
    NSLog(@"提醒");
    
    RemindViewController * remind =[[RemindViewController alloc]init];
    [self.navigationController pushViewController:remind animated:YES];
  
}
- (void)btn2Click
{
    NSLog(@"guanyu");

    AboutViewController * about = [[AboutViewController alloc]init];
    [self.navigationController pushViewController:about animated:YES];
}

- (void)loginClick
{

    NSLog(@"DJS");


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

@end
