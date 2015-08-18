//
//  register3ViewController.m
//  zhicai
//
//  Created by perfect on 15/3/23.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "LoginViewController.h"
#import "UserModel.h"
#import "FTApi.h"
#import "Register3ViewController.h"
#import "MainTabBarController.h"
#import "SVProgressHUD.h"
@interface Register3ViewController ()<UITextFieldDelegate>
{
    UITextField * loginFiled;
    UITextField * sureFiled;
    UIButton * logbtn;
    UIView * view;

}
@end

@implementation Register3ViewController

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
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"登录"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
    
   // CGRectMake(16, 33, 12*0.9, 21*0.9)
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    
    [navView addSubview:backBtn];
    

    
}

- (void)createView
{
    //104
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 104, MRScreenWidth, 94)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * userLab = [MyControl createLabelFrame:CGRectMake(16, 0, 70, 47) font:15 Text:@"登录密码"];
    userLab.textAlignment = YES;
    [view addSubview:userLab];
    

    loginFiled = [MyControl createTextFieldFrame:CGRectMake(75+20, 0, self.view.frame.size.width-45, 47) Placeholder:@"密码为六位纯数字" leftView:nil rightView:nil BgImageName:nil font:15];
    loginFiled.delegate = self;
    loginFiled.keyboardType = UIKeyboardTypeNumberPad;//数字键盘
    [view addSubview:loginFiled];

    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 46, MRScreenWidth, 1)];
    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [view addSubview:lineView];
    
    UILabel * pwdLab = [MyControl createLabelFrame:CGRectMake(16, 47, 50+20, 47) font:15 Text:@"确认密码"];
    pwdLab.textAlignment = YES;
    [view addSubview:pwdLab];
    
    sureFiled = [MyControl createTextFieldFrame:CGRectMake(75+20, 47, MRScreenWidth-45, 47) Placeholder:@"请再次输入登录密码" leftView:nil rightView:nil BgImageName:nil font:15];
    sureFiled.secureTextEntry = YES;//密码遮掩
    sureFiled.delegate = self;
    sureFiled.keyboardType = UIKeyboardTypeNumberPad;//数字键盘
    [view addSubview:sureFiled];
    
    [[NSUserDefaults standardUserDefaults]setObject:sureFiled.text forKey:CURRENT_USER_PWD];
    
    
    
    logbtn = [MyControl createButtonFrame:CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49) Title:@"登录" BgImageName:nil ImageName:nil Method:@selector(loginClick) target:self];
    
    logbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [logbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    logbtn.backgroundColor = [MyControl getColor:@"D4D4D4"];
    [self.view addSubview:logbtn];
    
    
}

- (void)backClick
{
    
    NSLog(@"hah");
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (void)loginClick
{
    
    NSLog(@"登录");
//    MainTabBarController * mainTab = [[MainTabBarController alloc]init];
//   // [self.navigationController pushViewController:mainTab animated:YES];
//    
//    
//    [self presentViewController:mainTab animated:YES completion:^{
//        
//    }];
    //loginFiled
    //sureFiled
    
    if (loginFiled.text.length == 0 || sureFiled.text.length==0)
    {
        [SVProgressHUD show];
        [SVProgressHUD dismissWithError:@"填写不能为空" afterDelay:1.5];
        return;
    }
    if (loginFiled.text.length >7 ||sureFiled.text.length >7)
    {
        [SVProgressHUD show];
        [SVProgressHUD dismissWithError:@"密码设置不符" afterDelay:1.5];
        return;
    }
    
//    if (sureFiled.text.length >4)
//    {
//        [SVProgressHUD show];
//        [SVProgressHUD dismissWithError:@"密码设置不符" afterDelay:1.5];
//        return;
//    }
    if (![loginFiled.text isEqualToString:sureFiled.text]) {
        [SVProgressHUD show];
        [SVProgressHUD dismissWithError:@"确认密码有误" afterDelay:1.0];
        
        
      }else{
          
          NSString* url = @"o/regist";
          NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
          [params setObject:sureFiled.text forKey:@"userPassword"];
          [params setObject:self.phoneNo forKey:@"mobile"];
          [params setObject:self.codeArr[0] forKey:@"code"];
          [params setObject:self.codeArr[1] forKey:@"codeId"];
          [Httptool postWithURL:url Params:params Success:^(id json, HttpCode code) {
              NSDictionary* dic = (NSDictionary*)json;
              NSLog(@"%@",dic);
//              LoginViewController* loginvc =[[LoginViewController alloc]init];
//              [self presentViewController:loginvc animated:YES completion:nil];
              
              if ([[dic objectForKey:@"code"] integerValue] == kHttpStatusOK) {
                  
                  UserModel* model = [UserModel objectWithKeyValues:[dic objectForKey:@"data"]];
                  gAppDelegate.userModel = model;
                  [[NSUserDefaults standardUserDefaults] setValue:gAppDelegate.userModel.mobilePhone forKey:@"LoginUserName"];
                  [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:kIsLogin];

                  [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"tokenId"] forKey:kLoginTokenIdentifier];
                  
                  MainTabBarController * mainTab = [[MainTabBarController alloc]init];
                  [self presentViewController:mainTab animated:YES completion:nil];
//
              }else{
                  [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
              }
//   
          } Failure:^(NSError *error) {
          
          }];
//        NSString* url = [NSString 321stringWithFormat:@"regist?userPassword=%@&mobile=%@",sureFiled.text,self.phoneNo];
//          [Httptool GetHandlerWithHandlerWithUrlStr:url HttpRequestHandlerCaller:ZhiXuanLCHttpServer finished:^(id result, HttpCode code, AFHTTPRequestOperation *operation) {
//              NSLog(@"*****%@****",result);
//          } failured:^{
//              
//          }];
    
    }
    
    
}
-(void)showKeyBoard:(NSNotification*)notification{
    
    [UIView animateWithDuration:0.5 animations:^{
        logbtn.frame = CGRectMake(0, MRScreenHeight-220-49, MRScreenWidth, 49);
        logbtn.backgroundColor = [MyControl getColor:@"#31424A"];
    }];
    
    
//    if (iPhone4) {
//        [UIView animateWithDuration:0.5 animations:^{
//            view.center =CGPointMake(view.center.x, view.center.y-40);//100
//            // groundView.backgroundColor = [UIColor redColor];
//            logbtn.frame = CGRectMake(0, MRScreenHeight-250-49, MRScreenWidth, 49);
//            logbtn.backgroundColor = [MyControl getColor:@"#31424A"];
//        }];
//    }else{
//        [UIView animateWithDuration:0.5 animations:^{
//            view.frame =CGRectMake(0, 104, MRScreenWidth, 94);//100
//            // groundView.backgroundColor = [UIColor redColor];
//            logbtn.frame = CGRectMake(0, MRScreenHeight-49-220, MRScreenWidth, 49);
//            logbtn.backgroundColor = [MyControl getColor:@"#31424A"];
//            
//        }];
//        
//        
//    }
    
    
}
-(void)hideKeyBoard:(NSNotification*)notification{
    [UIView animateWithDuration:0.5 animations:^{
        
        //view.frame =CGRectMake(0, 104, MRScreenWidth, 94);
        logbtn.frame = CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49);
        logbtn.backgroundColor = [MyControl getColor:@"D4D4D4"];

    }];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [loginFiled resignFirstResponder];
    [sureFiled resignFirstResponder];
    return YES;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [loginFiled resignFirstResponder];
    [sureFiled resignFirstResponder];


}
- (void)viewWillAppear:(BOOL)animated
{
    
    self.parentViewController.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    
    self.parentViewController.tabBarController.tabBar.hidden = NO;
   // [[NSNotificationCenter defaultCenter] removeObserver:self];

}



@end
