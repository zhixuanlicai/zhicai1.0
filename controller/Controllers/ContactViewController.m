//
//  contactViewController.m
//  zhicai
//
//  Created by perfect on 15/3/25.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()<UITextViewDelegate,UITextFieldDelegate>
{
    UITextView * textView;
    UILabel * placeLab;
    UIScrollView * myScrollView;
    BOOL keyboardShow;
    UITextField * emailFiled;
    UIButton * connectBtn;
    
    UIView * groundView;

}
@end

@implementation ContactViewController

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
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, kStatusBarHeight)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef6];
    [self.view addSubview:navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"用户反馈"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
    
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    [navView addSubview:backBtn];
    
}

- (void)createView
{
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, MRScreenHeight-64)];
    [myScrollView setContentSize:CGSizeMake(MRScreenWidth, MRScreenHeight+200)];
    myScrollView.userInteractionEnabled = YES;
    myScrollView.backgroundColor = [UIColor redColor];
   // [self.view addSubview:myScrollView];
    
    groundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, 211)];
    groundView.backgroundColor = [MyControl getColor:@"EDEDED"];
    
    [self.view addSubview:groundView];
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(16, 16, MRScreenWidth-16*2, 150)];
    [groundView addSubview:textView];
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = [UIFont systemFontOfSize:14];
    textView.delegate = self;
    textView.keyboardType = UIReturnKeyDefault;
    placeLab = [MyControl createLabelFrame:CGRectMake(10, 0, 60, 30) font:13 Text:@"我要留言"];
    placeLab.enabled = NO;//label设置不可用
    [textView addSubview:placeLab];
    
    UILabel * methodlab = [MyControl createLabelFrame:CGRectMake(24, 150+15+15, 60, 30) font:15 Text:@"联系方式"];
    //methodlab.textAlignment = YES;
    methodlab.textColor = [MyControl getColor:@"#31414A"];
    //methodlab.backgroundColor =[UIColor redColor];
    [groundView addSubview:methodlab];
    emailFiled = [MyControl createTextFieldFrame:CGRectMake(24+60+10, 150+15+15, MRScreenWidth-120, 30) Placeholder:@"用户邮箱" leftView:nil rightView:nil BgImageName:nil font:11];
    emailFiled.delegate = self;
    emailFiled.keyboardType = UIReturnKeyDefault;
    emailFiled.backgroundColor = [UIColor whiteColor];
    [groundView addSubview:emailFiled];
    
    connectBtn = [MyControl createButtonFrame:CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49) Title:@"提交" BgImageName:nil ImageName:nil Method:@selector(submitClick) target:self];
   
    connectBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [connectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    connectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    connectBtn.backgroundColor = [MyControl getColor:@"D4D4D4"];
    [self.view addSubview:connectBtn];
    
}

//判断邮箱格式是否正确
- (BOOL)isValidateEmail:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}

//移除提示框
-(void)dismiss
{
    [SVProgressHUD dismiss];
}

- (void)submitClick
{
    if ([self isValidateEmail:emailFiled.text]) {
        
        NSString* url = @"o/concatus";
        NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
        [params setObject:emailFiled.text forKey:@"email"];
        [params setObject:textView.text forKey:@"content"];
        
        [Httptool postWithURL:url Params:params Success:^(id json, HttpCode code) {
            NSDictionary* dic = (NSDictionary*)json;
            NSLog(@"%@",dic);
            if ([[dic objectForKey:@"code"] intValue] == 200) {
                
                [SVProgressHUD showSuccessWithStatus:@"感谢你的来信" duration:2];
             //   [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
            }else{
                [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
            }
        }Failure:^(NSError *error) {
            
        }];
    }else{
      //邮箱错误
        [SVProgressHUD showErrorWithStatus:@"邮箱格式错误" duration:2];
       // [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
    }

}

- (void)backClick
{
   [self.navigationController popViewControllerAnimated:YES];
    self.parentViewController.tabBarController.tabBar.hidden = NO;
}
- (void)showKeyBoard:(NSNotification *)notification
{
    if (iPhone4) {
                [UIView animateWithDuration:0.5 animations:^{
                    groundView.center =CGPointMake(groundView.center.x, groundView.center.y-100);//100
                    // groundView.backgroundColor = [UIColor redColor];
            connectBtn.frame = CGRectMake(0, MRScreenHeight-250-49, MRScreenWidth, 49);
            connectBtn.backgroundColor = [MyControl getColor:@"#509ef0"];
                }];
        
            }else{
                [UIView animateWithDuration:0.5 animations:^{
                    groundView.frame =CGRectMake(0, 64, MRScreenWidth, 211);//100
                    // groundView.backgroundColor = [UIColor redColor];
                    connectBtn.frame = CGRectMake(0, MRScreenHeight-250-49, MRScreenWidth, 49);
                    connectBtn.backgroundColor = [MyControl getColor:@"#509ef0"];
                }];
          
            }
}
- (void)hideKeyBoard:(NSNotification *)notification
{
  
    [UIView animateWithDuration:0.5 animations:^{
        groundView.frame =CGRectMake(0, 64, MRScreenWidth, 211);//100
        // groundView.backgroundColor = [UIColor redColor];
        connectBtn.frame = CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49);
        connectBtn.backgroundColor = [MyControl getColor:@"#509ef0"];
    }];


}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textView resignFirstResponder];
    [emailFiled resignFirstResponder];
    return YES;    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
 if (![text isEqualToString:@""])
 {
     placeLab.hidden = YES;
 }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        placeLab.hidden = NO;
    }
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    [textView resignFirstResponder];
    [emailFiled resignFirstResponder];

}


- (void)viewWillAppear:(BOOL)animated
{
    
    self.parentViewController.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    
    self.parentViewController.tabBarController.tabBar.hidden = NO;
}


@end
