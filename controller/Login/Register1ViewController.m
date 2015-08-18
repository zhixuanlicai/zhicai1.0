//
//  register1ViewController.m
//  zhicai
//
//  Created by perfect on 15/3/23.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "Register1ViewController.h"
#import "LoginViewController.h"
#import "Register2ViewController.h"
#import "Register3ViewController.h"
#import "SVProgressHUD.h"
#import "FTApi.h"
#import "SMS_SDK/SMS_SDK.h"
#import "SMS_SDK/CountryAndAreaCode.h"
#import "CodeModel.h"

@interface Register1ViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    UIView * bgView;
    
    UITextField * phoneNum;
    UITextField * yanzhengFiled;
    UIButton * nextBtn;
    UIButton * getBtn;//发送验证码
   // NSUserDefaults * userInfo;
    NSTimer *_timer;
    CodeModel *_codeModel;
    NSMutableArray *_codeArr;

}

@property (nonatomic,assign) NSInteger seconds;

@end

@implementation Register1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    
    _codeArr = [[NSMutableArray alloc] init];
    self.seconds = 60;
    CountryAndAreaCode * country=[[CountryAndAreaCode alloc] init];
    country.countryName=@"China";
    country.areaCode=@"86";
    [self createNav];
      [self createView];
    //通知中心，键盘的弹出和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    
//     userInfo =[NSUserDefaults standardUserDefaults];

}
- (void)createNav
{
    self.view.backgroundColor = [MyControl getColor:@"EDEDED"];
    self.navigationController.navigationBarHidden = YES;
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, kStatusBarHeight)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"请输入手机号注册"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
    
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    //backImg.backgroundColor = [UIColor purpleColor];
    
    [navView addSubview:backBtn];
    
}

- (void)createView
{

    
    UILabel * txtLab = [MyControl createLabelFrame:CGRectMake(0, 64, MRScreenWidth, 40) font:12 Text:@"请输入手机号进行注册、登录"];
    txtLab.textAlignment = NSTextAlignmentCenter;
    txtLab.textColor = [MyControl getColor:@"#8F8F8F"];
    [self.view addSubview:txtLab];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, 47*2)];//47*2
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel * phoneLab = [MyControl createLabelFrame:CGRectMake(16, 0, 50, 47) font:15 Text:@"手机号"];
    phoneLab.textColor = [UIColor blackColor];
    [view addSubview:phoneLab];
    
    phoneNum = [MyControl createTextFieldFrame:CGRectMake(75, 0, MRScreenWidth-55, 47) Placeholder:@"请输入手机号" leftView:nil rightView:nil BgImageName:nil font:15];
    phoneNum.delegate = self;
    phoneNum.keyboardType = UIKeyboardTypeNumberPad;//数字键盘
    [view addSubview:phoneNum];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 46, MRScreenWidth, 1)];
    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [view addSubview:lineView];
    
    UILabel * yanLab = [MyControl createLabelFrame:CGRectMake(16, 47, 50, 47) font:15 Text:@"验证码"];
    phoneLab.textColor = [UIColor blackColor];
    [view addSubview:yanLab];
    
    yanzhengFiled = [MyControl createTextFieldFrame:CGRectMake(75, 47, 100, 47) Placeholder:@"请输入验证码" leftView:nil rightView:nil BgImageName:nil font:15];
    yanzhengFiled.delegate = self;
    yanzhengFiled.keyboardType = UIKeyboardTypeNumberPad;//数字键盘
    [view addSubview:yanzhengFiled];
    
    
    getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getBtn.frame =CGRectMake(MRScreenWidth-120, 48, 120, 46);
    [getBtn addTarget:self action:@selector(getClick) forControlEvents:UIControlEventTouchUpInside];
    getBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [getBtn setTitleColor:[MyControl getColor:@"#5fafe4"] forState:UIControlStateNormal];
    getBtn.layer.borderColor = [[MyControl getColor:@"#6CB5E6"]CGColor];
    getBtn.layer.borderWidth = 1.0f;
    //getBtn.backgroundColor = [UIColor redColor];
    
    [getBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [view addSubview:getBtn];
    
    
    nextBtn = [MyControl createButtonFrame:CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49) Title:@"下一步" BgImageName:nil ImageName:nil Method:@selector(nextClick:) target:self];
    nextBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    nextBtn.backgroundColor = [MyControl getColor:@"D4D4D4"];
    [self.view addSubview:nextBtn];
    
    
   
    
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

- (BOOL)isMobilePhone:(NSString *)str
{
    NSString *	regex = @"(^[0-9]{11}$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:str];
}

- (void)getClick
{

//    
//    __block int timeout=60; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout<=0){ //倒计时结束，关闭
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                [getBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
//                getBtn.userInteractionEnabled = YES;
//                
//            });
//            
//        }else{
//            //            int minutes = timeout / 60;
//            // 如果是30秒之后发送就%60
//            int seconds = timeout % 120;
//            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                NSLog(@"____%@",strTime);
//                [getBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
//                getBtn.userInteractionEnabled = NO;
//                
//            });
//            timeout--;
//            
//        }
//    });
//    dispatch_resume(_timer);
//    
    
    [phoneNum endEditing:YES];
    NSString* rule1=[NSString stringWithFormat:@"^1(3|5|7|8|4)\\d{9}"];
    NSPredicate* pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",rule1];
    BOOL isMatch=[pred evaluateWithObject:phoneNum.text];
    if (phoneNum.text.length!=11) {
        //手机号码不正确
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"通知" message:@"手机格式不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    else if (!isMatch) {
        //手机号码不正确
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"通知" message:@"手机号码不正确"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    NSString * str = [NSString stringWithFormat:@"电话:%@",phoneNum.text];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"发送验证信息" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
//    [SVProgressHUD show];
//    
//    if (phoneNum.text.length == 0) {
//        [SVProgressHUD show];
//        [SVProgressHUD dismissWithError:@"填写不能为空" afterDelay:1.5];
//        return;
//    }
//    
//    if (![self isMobilePhone:phoneNum.text]) {
//        [SVProgressHUD show];
//        [SVProgressHUD dismissWithError:@"手机格式不正确" afterDelay:2.0];
//        return;
//    }
    NSLog(@"phoneNum.text==%@",phoneNum.text);
    
    
}

- (void)nextClick:(NSTimer *)theTimer
{
    Register3ViewController * reg3 = [[Register3ViewController alloc]init];
    reg3.phoneNo = phoneNum.text;
    reg3.codeArr = _codeArr;
    
    [self.navigationController pushViewController:reg3 animated:YES];


}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1==buttonIndex)
    {
        NSLog(@"点击了确定按钮");
        
        NSString* url = @"o/sendVerifyCode";
        NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
        [params setObject:phoneNum.text forKey:@"mobile"];
        [Httptool postWithURL:url Params:params Success:^(id json, HttpCode code) {
            
            NSDictionary* dic = (NSDictionary*)json;
            
            if ([[dic objectForKey:@"code"] intValue] == 200) {
                _codeModel = [[CodeModel alloc] init];
                //获取到的验证码
                _codeModel.code = dic[@"data"][@"Rcode"];
                _codeModel.codeId = dic[@"data"][@"RcodeId"];
                [_codeArr addObject:_codeModel.code];
                [_codeArr addObject:_codeModel.codeId];
                
                NSLog(@"++++++++++%@",_codeModel.code);
                
                _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
                
            }else{
                //[SVProgressHUD show];
                //[SVProgressHUD dismissWithError:@"请重新输入密码" afterDelay:1.0];
                [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
            }
        }Failure:^(NSError *error) {
            
        }];
        
    }if(0==buttonIndex) {
        NSLog(@"点击了取消按钮");
    }

}
#pragma mark NStimerMethod
-(void)timerFireMethod:(NSTimer *)timer {
    if (self.seconds == 1) {
        [timer invalidate];
        self.seconds = 60;
        [getBtn setTitle:@"获取验证码" forState: UIControlStateNormal];
        
        [getBtn setEnabled:YES];
    }else{
        self.seconds--;
//        NSLog(@"%ld",self.seconds);
        [getBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新发送",self.seconds] forState:UIControlStateNormal];
        //                getBtn.userInteractionEnabled = NO;

    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [phoneNum resignFirstResponder];
    [yanzhengFiled resignFirstResponder];
    return YES;

}
//触摸键盘消失
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [phoneNum resignFirstResponder];
    [yanzhengFiled resignFirstResponder];
}
-(void)showKeyBoard:(NSNotification*)notification{
    [UIView animateWithDuration:0.5 animations:^{
        nextBtn.frame = CGRectMake(0, MRScreenHeight-49-220, MRScreenWidth, 49);
        nextBtn.backgroundColor = [MyControl getColor:@"#31424A"];
    }];
    
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
    //[[NSNotificationCenter defaultCenter] removeObserver:self];

}

@end
