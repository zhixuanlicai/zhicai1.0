//
//  register2ViewController.m
//  zhicai
//
//  Created by perfect on 15/3/23.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "Register2ViewController.h"
#import "Register3ViewController.h"
@interface Register2ViewController ()<UITextFieldDelegate>
{
    UIView * bgView;
    UITextField * yanzhengFiled;
    UIButton * nextBtn1;


}
@end

@implementation Register2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    //self.seconds = 60;
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
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"注册"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"010D12"];
    [navView addSubview:navlab];
    
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(16, 33, 12*0.9, 21*0.9) Title:nil BgImageName:nil ImageName:@"fanhui@2x.png" Method:@selector(backClick) target:self];
    // backBtn.backgroundColor = [UIColor redColor];
    [navView addSubview:backBtn];
    
    
}

- (void)createView
{
    
    UILabel * txtLab = [MyControl createLabelFrame:CGRectMake(0, 64, MRScreenWidth, 40) font:12 Text:@"验证码短信（免费）已发送"];
    txtLab.textAlignment = NSTextAlignmentCenter;
    txtLab.textColor = [MyControl getColor:@"#8F8F8F"];
    [self.view addSubview:txtLab];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, 47)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel * phoneLab = [MyControl createLabelFrame:CGRectMake(16, 0, 50, 47) font:15 Text:@"验证码"];
    phoneLab.textColor = [UIColor blackColor];
    [view addSubview:phoneLab];
    
//    UIButton * getBtn = [MyControl createButtonFrame:CGRectMake(MRScreenWidth-16-60, 0, 60, 47) Title:@"重发" BgImageName:nil ImageName:nil Method:@selector(getClick) target:self];
//        [getBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    getBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    
    self.timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.timeBtn.frame =CGRectMake(MRScreenWidth-16-100, 0, 100, 47);
    [self.timeBtn addTarget:self action:@selector(timeClick:) forControlEvents:UIControlEventTouchUpInside];
    self.timeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.timeBtn setTitleColor:[MyControl getColor:@"#5fafe4"] forState:UIControlStateNormal];
    //  getBtn.backgroundColor = [UIColor grayColor];
    [self.timeBtn setTitle:@"重发" forState:UIControlStateNormal];
    [view addSubview:self.timeBtn];
    
    
//     [getBtn setTitleColor:[MyControl getColor:@"#5fafe4"] forState:UIControlStateNormal];
//    getBtn.titleLabel.textAlignment = YES;
//        [view addSubview:getBtn];
    yanzhengFiled = [MyControl createTextFieldFrame:CGRectMake(75, 0, 120, 47) Placeholder:@"请输入验证码" leftView:nil rightView:nil BgImageName:nil font:15];
    yanzhengFiled.delegate = self;
    yanzhengFiled.keyboardType = UIKeyboardTypeNumberPad;
    [view addSubview:yanzhengFiled];
    
    nextBtn1 = [MyControl createButtonFrame:CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49) Title:@"下一步" BgImageName:nil ImageName:nil Method:@selector(nextClick) target:self];
    nextBtn1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn1.titleLabel.font = [UIFont systemFontOfSize:15];
    nextBtn1.backgroundColor = [MyControl getColor:@"D4D4D4"];
    [self.view addSubview:nextBtn1];
    
    UIButton * reBtn = [MyControl createButtonFrame:CGRectMake(MRScreenWidth-16-120, 151, 120, 47) Title:@"重新获取验证码" BgImageName:nil ImageName:nil Method:@selector(reClick) target:self];
    [reBtn setTitleColor:[MyControl getColor:@"f97252"] forState:UIControlStateNormal];
    reBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:reBtn];

    
}

-(void)backClick
{
    //    loginViewController * login = [[loginViewController alloc]init];
    //    [self presentViewController:login animated:YES completion:^{
    //
    //    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"会就爱吃");
    
}

- (void)nextClick
{
    
    Register3ViewController * reg3 = [[Register3ViewController alloc]init];
    [self.navigationController pushViewController:reg3 animated:YES];
    
    
}

- (void)timeClick:(NSTimer *)theTimer
{

    NSLog(@"倒计时");
//    
//    if (self.seconds == 1) {
//        [theTimer invalidate];
//        self.seconds = 60;
//        [self.timeBtn setTitle:@"重发" forState: UIControlStateNormal];
//        [self.timeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        [self.timeBtn.titleLabel setFont:[UIFont fontWithName:nil size:12.0]];
//        [self.timeBtn setEnabled:YES];
//    }else{
//        self.seconds--;
//        NSLog(@"%ld",self.seconds);
//        [self.timeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        [self.timeBtn setTitle:[NSString stringWithFormat:@"获取验证码(%ld)",self.seconds] forState:UIControlStateDisabled];
//        [self.timeBtn.titleLabel setFont:[UIFont fontWithName:nil size:11.0]];
//        [self.timeBtn setEnabled:NO];
//        
//    }


}

- (void)reClick
{
    NSLog(@"重新获取");

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [yanzhengFiled resignFirstResponder];
    return YES;
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    [yanzhengFiled resignFirstResponder];

}


-(void)showKeyBoard:(NSNotification*)notification{
    
    
    nextBtn1.frame = CGRectMake(0, MRScreenHeight-49-220, MRScreenWidth, 49);
    nextBtn1.backgroundColor = [MyControl getColor:@"#31424A"];
    
}
-(void)hideKeyBoard:(NSNotification*)notification{
    
    nextBtn1.frame = CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49);
    nextBtn1.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    
}

//tabbar的隐藏与出现
- (void)viewWillAppear:(BOOL)animated
{
    
    self.parentViewController.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    
    self.parentViewController.tabBarController.tabBar.hidden = NO;
   // [[NSNotificationCenter defaultCenter] removeObserver:self];

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
