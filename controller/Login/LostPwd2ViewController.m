//
//  lostPwd2ViewController.m
//  zhicai
//
//  Created by perfect on 15/4/8.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "LostPwd2ViewController.h"
#import "LoginViewController.h"
@interface LostPwd2ViewController ()<UITextFieldDelegate>
{
    UIView * bgView;
    UIButton * nextBtn;
    UITextField * password;
    UITextField * newFiled;
    
}
@end

@implementation LostPwd2ViewController

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
    navView.backgroundColor = [MyControl getColor:@"0x509ef0"];
    [self.view addSubview:navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"忘记密码"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
    
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];    
    [navView addSubview:backBtn];
    
}

- (void)createView
{
    
    
    UILabel * txtLab = [MyControl createLabelFrame:CGRectMake(0, 64, MRScreenWidth, 40) font:12 Text:@"验证码短信（免费）已发送"];
    txtLab.textAlignment = NSTextAlignmentCenter;
    txtLab.textColor = [MyControl getColor:@"#8F8F8F"];
    [self.view addSubview:txtLab];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, 47*2)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
  //  UILabel * phoneLab = [MyControl createLabelFrame:CGRectMake(16, 0, 90, 47) font:15 Text:@"身份证号码"];
    UILabel * phoneLab = [MyControl createLabelFrame:CGRectMake(16, 0, 90, 47) font:15 Text:@"设置新密码"];
   // phoneLab.backgroundColor = [UIColor redColor];
    phoneLab.textColor = [UIColor blackColor];
    [view addSubview:phoneLab];
    
    password = [MyControl createTextFieldFrame:CGRectMake(120, 0, MRScreenWidth-120, 47) Placeholder:@"请设置六位数字新密码" leftView:nil rightView:nil BgImageName:nil font:15];
    password.delegate = self;
    password.keyboardType = UIKeyboardTypeAlphabet;
    [view addSubview:password];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 46, MRScreenWidth, 1)];
    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [view addSubview:lineView];
    
    UILabel * yanLab = [MyControl createLabelFrame:CGRectMake(16, 47, 90, 47) font:15 Text:@"确认新密码"];
    phoneLab.textColor = [UIColor blackColor];
    
    [view addSubview:yanLab];
    
    newFiled = [MyControl createTextFieldFrame:CGRectMake(120, 47, MRScreenWidth-120, 47) Placeholder:@"请确认六位数字新密码" leftView:nil rightView:nil BgImageName:nil font:15];
    newFiled.delegate = self;
    newFiled.keyboardType = UIKeyboardTypeNumberPad;//数字键盘
    // yanzhengFiled.backgroundColor = [UIColor purpleColor];
    [view addSubview:newFiled];
    
    
    nextBtn = [MyControl createButtonFrame:CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49) Title:@"确认更改" BgImageName:nil ImageName:nil Method:@selector(nextClick) target:self];
    nextBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    nextBtn.backgroundColor = [MyControl getColor:@"D4D4D4"];
    [self.view addSubview:nextBtn];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"会就爱吃");
    
}

- (void)nextClick
{
    NSString* url = @"o/findPwd";
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setObject:self.code forKey:@"code"];
    [params setObject:self.codeId forKey:@"codeId"];
    //可能后台参数名有问题
    [params setObject:self.phoneNum forKey:@"mobile"];
    [params setObject:newFiled.text forKey:@"newPwd"];
    [Httptool postWithURL:url Params:params Success:^(id json, HttpCode code) {
        
        NSDictionary* dic = (NSDictionary*)json;
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"code"] intValue] == 200) {
        
            LoginViewController * login = [[LoginViewController alloc]init];
            login.username = self.phoneNum;
            [self.navigationController pushViewController:login animated:YES];
            
//         _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        }else{
            //[SVProgressHUD show];
            //[SVProgressHUD dismissWithError:@"请重新输入密码" afterDelay:1.0];
            [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
        }
    }Failure:^(NSError *error) {
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [password resignFirstResponder];
    [newFiled resignFirstResponder];
    return YES;
}
//触摸键盘消失
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [password resignFirstResponder];
    [newFiled resignFirstResponder];
}
-(void)showKeyBoard:(NSNotification*)notification{
    
    nextBtn.frame = CGRectMake(0, MRScreenHeight-49-245, MRScreenWidth, 49);
    nextBtn.backgroundColor = [MyControl getColor:@"#31424A"];
    
}
-(void)hideKeyBoard:(NSNotification*)notification{
    
    nextBtn.frame = CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49);
    nextBtn.backgroundColor = [MyControl getColor:@"#D4D4D4"];
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
