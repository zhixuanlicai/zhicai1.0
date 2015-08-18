//
//  loginViewController.m
//  zhicai
//
//  Created by perfect on 15/3/23.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "AppDelegate.h"
#import "UserModel.h"
#import "LoginViewController.h"
#import "Register1ViewController.h"
#import "SVProgressHUD.h"
#import "LostPwdController.h"
#import "MainTabBarController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UIButton * loginBtn;
    UITextField * userFiled;
    UITextField * pwdFiled;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor grayColor];
    self.navigationController.navigationBar.translucent = NO;

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
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    self.navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:self.navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"登录"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [self.navView addSubview:navlab];
    
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    
    [self.navView addSubview:backBtn];
    
    UIButton * regBtn = [MyControl createButtonFrame:CGRectMake(MRScreenWidth-16-40, 20, 40, 40) Title:@"注册" BgImageName:nil ImageName:nil Method:@selector(regClick) target:self];
    regBtn.titleLabel.textAlignment = YES;
    [regBtn setTitleColor:[MyControl getColor:@"#ffffff"] forState:UIControlStateNormal];
    regBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.navView addSubview:regBtn];
    
    
    
}

- (void)createView
{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 104, MRScreenWidth, 94)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * userLab = [MyControl createLabelFrame:CGRectMake(16, 0, 30, 47) font:15 Text:@"账号"];
    userLab.textAlignment = YES;
    [view addSubview:userLab];
    
    userFiled = [MyControl createTextFieldFrame:CGRectMake(55, 0, self.view.frame.size.width-45, 47) Placeholder:@"用户名/电话号码" leftView:nil rightView:nil BgImageName:nil font:15];
    userFiled.delegate = self;
    userFiled.returnKeyType = UIReturnKeyGo;
    userFiled.keyboardType = UIKeyboardTypeNumberPad;//数字键盘
   //   userFiled.returnKeyType = UIReturnKeyDefault;
    userFiled.text = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserName];
    [view addSubview:userFiled];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 46, MRScreenWidth, 1)];
    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [view addSubview:lineView];
    
    UILabel * pwdLab = [MyControl createLabelFrame:CGRectMake(16, 47, 30, 47) font:15 Text:@"密码"];
    pwdLab.textAlignment = YES;
    [view addSubview:pwdLab];
    
    pwdFiled = [MyControl createTextFieldFrame:CGRectMake(55, 47, 150, 47) Placeholder:@"请输入登录密码" leftView:nil rightView:nil BgImageName:nil font:15];
    pwdFiled.secureTextEntry = YES;//密码遮掩
    pwdFiled.delegate = self;
    pwdFiled.returnKeyType = UIReturnKeyGo;
    pwdFiled.keyboardType = UIKeyboardTypeNumberPad;//数字键盘
    [view addSubview:pwdFiled];
    
    UIButton * forgetBtn = [MyControl createButtonFrame:CGRectMake(self.view.frame.size.width-60-16, 47, 60, 47) Title:@"忘记密码" BgImageName:nil ImageName:nil Method:@selector(forgetClick) target:self];
    forgetBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [forgetBtn setTitleColor:[MyControl getColor:@"#f97252"] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:forgetBtn];

//    logView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
//    [self.view addSubview:logView];
//    logView.backgroundColor = [UIColor redColor];
    
    loginBtn = [MyControl createButtonFrame:CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49) Title:@"登录" BgImageName:nil ImageName:nil Method:@selector(loginClick) target:self];
    loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
     loginBtn.backgroundColor = [MyControl getColor:@"D4D4D4"];
    [self.view addSubview:loginBtn];
}

- (void)backClick
{

    [self.navigationController popViewControllerAnimated:YES];
    self.parentViewController.tabBarController.tabBar.hidden = NO;
}
- (void)regClick
{

    Register1ViewController * reg = [[Register1ViewController alloc]init];
    [self.navigationController pushViewController:reg animated:YES];
}
-(void)forgetClick
{
    
    NSLog(@"jcdasvb");
    LostPwdController * lost = [[LostPwdController alloc]init];
    [self.navigationController pushViewController:lost animated:YES];

}

- (void)loginClick
{
    NSString* url = @"o/login";
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setObject:userFiled.text forKey:@"username"];
    [params setObject:pwdFiled.text forKey:@"password"];
    [Httptool postWithURL:url Params:params Success:^(id json, HttpCode code) {
        if (code == kHttpStatusOK) {
            NSLog(@"%@",json);
            NSDictionary* dic = (NSDictionary*)json;
        
            if ([[dic objectForKey:@"code"] intValue] == 200) {
                
                
                NSDictionary* userdic = [dic objectForKey:@"data"];
                UserModel* user = [UserModel objectWithKeyValues:userdic];
                gAppDelegate.userModel = user;
                gAppDelegate.isLogin = YES;
                [[NSUserDefaults standardUserDefaults] setValue:gAppDelegate.userModel.mobilePhone forKey:@"LoginUserName"];
                [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:kIsLogin];
                [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"tokenId"] forKey:kLoginTokenIdentifier];
                MainTabBarController * tab = [[MainTabBarController alloc]init];
                //[gAppDelegate.window setRootViewController:tab];
                [self presentViewController:tab animated:YES completion:nil];

            }else{
                //[SVProgressHUD show];
                //[SVProgressHUD dismissWithError:@"请重新输入密码" afterDelay:1.0];
                [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
            }
            
            
        }
    } Failure:^(NSError *error) {
        
    }];
    

}
-(void)showKeyBoard:(NSNotification*)notification{
    
    loginBtn.frame = CGRectMake(0, MRScreenHeight-220-49, MRScreenWidth, 49);
    loginBtn.backgroundColor = [MyControl getColor:@"#31424A"];

    
}
-(void)hideKeyBoard:(NSNotification*)notification{
    
    loginBtn.frame = CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49);
    loginBtn.backgroundColor = [MyControl getColor:@"D4D4D4"];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [userFiled resignFirstResponder];
    [pwdFiled resignFirstResponder];
    return YES;

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    [userFiled resignFirstResponder];
    [pwdFiled resignFirstResponder];

}

- (void)viewWillAppear:(BOOL)animated
{

  self.parentViewController.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{

    self.parentViewController.tabBarController.tabBar.hidden = NO;
    
    //删除通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
@end
