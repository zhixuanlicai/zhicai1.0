//
//  changePwdController.m
//  zhicai
//
//  Created by perfect on 15/4/8.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "ChangePwdController.h"

@interface ChangePwdController ()<UITextFieldDelegate>
{
    UITextField * oldFlied;
    UITextField * newFiled;
    UITextField * sureFiled;
    UIButton * changeBtn;
    UIView * view;
    
}

@end

@implementation ChangePwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNav];
    [self createView];
    
    //通知中心，键盘的弹出和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)createNav
{
    self.view.backgroundColor = [MyControl getColor:@"EDEDED"];
    self.navigationController.navigationBarHidden = YES;
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"修改登录密码"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
    
   UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    [navView addSubview:backBtn];
    
}

- (void)createView
{
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, 216)];
    view.backgroundColor = [MyControl getColor:@"EDEDED"];
    [self.view addSubview:view];
    
    
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 20, MRScreenWidth, 44)];
    view1.backgroundColor = [UIColor whiteColor];
    [view addSubview:view1];

    UILabel * lab1 = [MyControl createLabelFrame:CGRectMake(16, 0, 100, 44) font:15 Text:@"账户"];
    lab1.textColor = [MyControl getColor:@"#31424A"];
    [view1 addSubview:lab1];
    
    UILabel * lab2 = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-120, 0, 120, 44) font:15 Text:gAppDelegate.userModel.mobilePhone];
    lab2.textColor = [MyControl getColor:@"#8F8F8F"];
    [view1 addSubview:lab2];
    lab2.textAlignment = NSTextAlignmentRight;
    
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 84, MRScreenWidth, 132)];
    view2.backgroundColor = [UIColor whiteColor];
    [view addSubview:view2];
    
    UILabel * lab3 = [MyControl createLabelFrame:CGRectMake(16, 0, 100, 44) font:15 Text:@"旧密码"];
    lab3.textColor = [MyControl getColor:@"#31424A"];
    [view2 addSubview:lab3];
    oldFlied  = [MyControl createTextFieldFrame:CGRectMake(120, 0, MRScreenWidth-120, 44) Placeholder:@"请输入登录密码" leftView:nil rightView:nil BgImageName:nil font:15];
    oldFlied.delegate = self;
    oldFlied.keyboardType = UIKeyboardTypePhonePad;
    [view2 addSubview:oldFlied];
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(16, 43, MRScreenWidth-32, 1)];
    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [view2 addSubview:lineView];
    
    
    UILabel * lab4 = [MyControl createLabelFrame:CGRectMake(16, 44, 100, 44) font:15 Text:@"新密码"];
    lab4.textColor = [MyControl getColor:@"#31424A"];
    [view2 addSubview:lab4];
    newFiled  = [MyControl createTextFieldFrame:CGRectMake(120, 44, MRScreenWidth-120, 44) Placeholder:@"请输入新的登录密码" leftView:nil rightView:nil BgImageName:nil font:15];
    newFiled.delegate = self;
    newFiled.keyboardType = UIKeyboardTypePhonePad;
    [view2 addSubview:newFiled];
    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake(16, 87, MRScreenWidth-32, 1)];
    lineView1.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [view2 addSubview:lineView1];
    
    
    UILabel * lab5 = [MyControl createLabelFrame:CGRectMake(16, 88, 100, 44) font:15 Text:@"确认新密码"];
    lab5.textColor = [MyControl getColor:@"#31424A"];
    [view2 addSubview:lab5];
    sureFiled  = [MyControl createTextFieldFrame:CGRectMake(120, 88, MRScreenWidth-120, 44) Placeholder:@"请再次输入新登录密码" leftView:nil rightView:nil BgImageName:nil font:15];
    sureFiled.delegate = self;
    sureFiled.keyboardType = UIKeyboardTypePhonePad;
    [view2 addSubview:sureFiled];
   changeBtn = [MyControl createButtonFrame:CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49) Title:@"登录" BgImageName:nil ImageName:nil Method:@selector(changeClick) target:self];
    changeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    changeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    changeBtn.backgroundColor = [MyControl getColor:@"D4D4D4"];
    [self.view addSubview:changeBtn];

}
- (void)backClick
{
  
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)changeClick
{

    NSLog(@"确认更改");
}
#pragma mark textfiledDelegate

- (void)showKeyBoard:(NSNotification *)notification
{
 
    if (iPhone4) {
        [UIView animateWithDuration:0.5 animations:^{
            view.center =CGPointMake(view.center.x, view.center.y-110);//100
            // groundView.backgroundColor = [UIColor redColor];
            changeBtn.frame = CGRectMake(0, MRScreenHeight-220-49, MRScreenWidth, 49);
            changeBtn.backgroundColor = [MyControl getColor:@"#31424A"];
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            view.frame =CGRectMake(0, 64, MRScreenWidth, 216);//100
            // groundView.backgroundColor = [UIColor redColor];
            changeBtn.frame = CGRectMake(0, MRScreenHeight-49-220, MRScreenWidth, 49);
            changeBtn.backgroundColor = [MyControl getColor:@"#31424A"];
            
        }];
    
    
    }
    
    
}
- (void)hideKeyBoard:(NSNotification *)notification
{
    
    //  groundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, 211)];
    //    groundView.backgroundColor = [UIColor greenColor];
    
//    if (iPhone4) {
//        [UIView animateWithDuration:0.5 animations:^{
//            NSLog(@"DSFBGGH");
//            groundView.center=CGPointMake(self.view.center.x, self.view.center.y-50);//100
//            // groundView.backgroundColor = [UIColor greenColor];
//            
//        }];
//    }
//    if (iPhone5) {
//        [UIView animateWithDuration:0.5 animations:^{
//            NSLog(@"DSFBGGH");
//            groundView.center=CGPointMake(groundView.center.x, groundView.center.y);//100
//            // groundView.backgroundColor = [UIColor greenColor];
//            
//        }];
//    }
//    if (iphone6) {
//        [UIView animateWithDuration:0.5 animations:^{
//            NSLog(@"DSFBGGH");
//            groundView.center=CGPointMake(groundView.center.x, groundView.center.y);//100
//            // groundView.backgroundColor = [UIColor greenColor];
//        }];
//        
//    }
//    if (iphone6P) {
//        [UIView animateWithDuration:0.5 animations:^{
//            NSLog(@"DSFBGGH");
//            groundView.center=CGPointMake(groundView.center.x, groundView.center.y);//100
//            // groundView.backgroundColor = [UIColor greenColor];
//            
//        }];
//        
//        
//        
//    }
    
    [UIView animateWithDuration:0.5 animations:^{
        view.frame =CGRectMake(0, 64, MRScreenWidth, 216);//100
        // groundView.backgroundColor = [UIColor redColor];
        changeBtn.frame = CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49);
        changeBtn.backgroundColor = [MyControl getColor:@"D4D4D4"];

            }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [oldFlied resignFirstResponder];
    [newFiled resignFirstResponder];
    [sureFiled resignFirstResponder];
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
