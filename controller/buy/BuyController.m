//
//  buyController.m
//  zhicai
//
//  Created by perfect on 15/4/7.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "MainTabBarController.h"
#import "BuyController.h"
#import "AddBankController.h"
#import "MyMoneyViewController.h"

@interface BuyController ()<UITextFieldDelegate>
{

    UITextField * priceFiled;
    UIView * priceView;
    UIButton * sbutton;
}
@end

@implementation BuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mycardarr = [[NSMutableArray alloc] init];
    [self connect];
    // Do any additional setup after loading the view.
    
    [self createNav];
    [self createView];
    
    //通知中心，键盘的弹出和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)connect{
  
    NSString* strurl = @"u/getUserInfoByMobile";
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:kLoginTokenIdentifier] forKey:@"TOKEN"];
    [param setObject:gAppDelegate.userModel.mobilePhone forKey:@"mobile"];
    [Httptool postWithURL:strurl Params:param Success:^(id json, HttpCode code) {
        NSDictionary* dic = (NSDictionary*)json;
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"code"] integerValue] == kHttpStatusOK) {
            NSArray* cardsarr = [[dic objectForKey:@"data"] objectForKey:@"cards"];
            for (NSDictionary* carddic in cardsarr) {
                BankCardModel* bankcardmodel = [BankCardModel objectWithKeyValues:carddic];
                [self.mycardarr addObject:bankcardmodel];
               
            }
            self.mybankcmodel = [self.mycardarr lastObject];
            if (self.isHomemodel) {
                self.haoLab.text = [NSString stringWithFormat:@"%@",self.mybankcmodel.bankName];
                self.numLab.text = [NSString stringWithFormat:@"（尾号：%@ ）",[self.mybankcmodel.cardNum substringFromIndex:self.mybankcmodel.cardNum.length-4]];
                
            }else{
                self.haoLab.text = [NSString stringWithFormat:@"%@",self.mybankcmodel.bankName];
                self.numLab.text = [NSString stringWithFormat:@"（尾号：%@ ）",[self.mybankcmodel.cardNum substringFromIndex:self.mybankcmodel.cardNum.length-4]];
                
            }

            
  

        }else{
            [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error) {
        
    }];

//    NSString* url = @"u/getUserLoingInfoByTOKEN";
//    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
//    [params setObject:gAppDelegate.userModel.tokenId forKey:@"TOKEN"];
//    [Httptool postWithURL:url Params:params Success:^(id json, HttpCode code) {
//        if (code == kHttpStatusOK) {
//            NSLog(@"%@",json);
//            NSDictionary* dic = (NSDictionary*)json;
//            
//            if ([[dic objectForKey:@"code"] intValue] == 200) {
//                
//                
//                NSDictionary* userdic = [dic objectForKey:@"data"];
//                UserModel* user = [UserModel objectWithKeyValues:userdic];
//                gAppDelegate.userModel = user;
//                gAppDelegate.isLogin = YES;
//                [[NSUserDefaults standardUserDefaults] setValue:gAppDelegate.userModel.mobilePhone forKey:@"LoginUserName"];
//                [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:kIsLogin];
//                [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"tokenId"] forKey:kLoginTokenIdentifier];
//                
//            }else{
//                //[SVProgressHUD show];
//                //[SVProgressHUD dismissWithError:@"请重新输入密码" afterDelay:1.0];
//                [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
//            }
//            
//            
//        }
//    } Failure:^(NSError *error) {
//        
//    }];


}
- (void)createNav
{
    self.view.backgroundColor = [MyControl getColor:@"EDEDED"];
    self.navigationController.navigationBarHidden = YES;
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"购买"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
    
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    // backBtn.backgroundColor = [UIColor redColor];
    [navView addSubview:backBtn];
    
}

- (void)createView
{

    priceView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, 245)];
   // priceView.backgroundColor = [MyControl getColor:@"EDEDED"];
   // priceView.backgroundColor = [UIColor redColor];
    [self.view addSubview:priceView];

    
    UIView * buyView= [[UIView alloc]initWithFrame:CGRectMake(0, 20, MRScreenWidth, 44)];
    buyView.backgroundColor = [UIColor whiteColor];
    [priceView addSubview:buyView];
    UILabel * buyLab = [MyControl createLabelFrame:CGRectMake(16, 0, 100, 44) font:15 Text:@"购买金额"];
    //buyLab.textColor = [MyControl getColor:@"#31424A"];
    [buyView addSubview:buyLab];
    
    
    priceFiled = [MyControl createTextFieldFrame:CGRectMake(120, 0, 200, 44) Placeholder:@"5000元 可供购买" leftView:nil rightView:nil BgImageName:nil font:15];
    priceFiled.delegate = self;
    priceFiled.keyboardType = UIKeyboardTypeNumberPad;
    [buyView addSubview:priceFiled];
    
//    UILabel * prLab = [MyControl createLabelFrame:CGRectMake(120, 0, 120, 44) font:15 Text:@"5000元  可供购买"];
//    prLab.textColor = [MyControl getColor:@"#8E8E8E"];
//    [priceView addSubview:prLab];
    
    UILabel * timeLab = [MyControl createLabelFrame:CGRectMake(16, 64, MRScreenWidth-16, 19) font:11 Text:@"预计显示收益时间：2015-03-06"];
    timeLab.textColor = [MyControl getColor:@"#5fafe4"];
    //timeLab.backgroundColor =[UIColor redColor];
    [priceView addSubview:timeLab];
    
    UIButton * bankBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    bankBtn.frame =CGRectMake(0, 100, MRScreenWidth, 44);
    bankBtn.backgroundColor = [UIColor whiteColor];
    [bankBtn addTarget:self action:@selector(bankClick) forControlEvents:UIControlEventTouchUpInside];
    [priceView addSubview:bankBtn];
    
    UILabel * bankLab = [MyControl createLabelFrame:CGRectMake(16, 0, 80, 44) font:15 Text:@"银行卡"];
    // bankLab.textColor = [MyControl getColor:@"#31424A"];
    [bankBtn addSubview:bankLab];
     self.haoLab = [MyControl createLabelFrame:CGRectMake(100, 0, 90, 44) font:13 Text:self.bankname];
    self.numLab = [MyControl createLabelFrame:CGRectMake(155, 0, 90, 44) font:11 Text:[NSString stringWithFormat:@"（尾号：%@ ）",[self.cardNO substringFromIndex:self.cardNO.length-4]]];

    self.haoLab.textColor = [MyControl getColor:@"#8E8E8E"];
    [bankBtn addSubview:self.haoLab];
    self.numLab.textColor = [MyControl getColor:@"#8E8E8E"];
    [bankBtn addSubview:self.numLab];
    
    UIImageView * img = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, (44-11)/2+3, 7, 11) imageName:@"dxiayib@1x.png"];
    [bankBtn addSubview:img];
    
    UIImageView * bankimg = [MyControl createImageViewFrame:CGRectMake(16, 152, 15, 12) imageName:@"tiaokuan@1x.png"];//144
    [priceView addSubview:bankimg];
    UILabel * agreeLab = [MyControl createLabelFrame:CGRectMake(40, 144, 80, 27) font:13 Text:@"我同意"];
    agreeLab.textColor =[MyControl getColor:@"#8E8E8E"];
    [priceView addSubview:agreeLab];

    sbutton = [MyControl createButtonFrame:CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49) Title:@"提交" BgImageName:nil ImageName:nil Method:@selector(sureClick) target:self];
    sbutton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [sbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sbutton.titleLabel.font = [UIFont systemFontOfSize:15];
    sbutton.backgroundColor = [MyControl getColor:@"D4D4D4"];
    [self.view addSubview:sbutton];
    
    
    
//    bankLab.backgroundColor = [UIColor redColor];
//    haoLab.backgroundColor = [UIColor greenColor];
//    numLab.backgroundColor = [UIColor purpleColor];
}
- (void)bankClick
{

    NSLog(@"cdfgtyu");
    AddBankController * add = [[AddBankController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
    

}
- (void)sureClick
{
    NSString* url = @"u/buyfinancing";
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:kLoginTokenIdentifier] forKey:@"TOKEN"];
    [params setObject:[NSString stringWithFormat:@"%@",self.isHomemodel? self.homemodel.finid:self.promodel.finId] forKey:@"finId"];
    [params setObject:[NSString stringWithFormat:@"%@",self.mybankcmodel.cardId] forKey:@"cardId"];
    [params setObject:priceFiled.text forKey:@"bitAmount"];
    [Httptool postWithURL:url Params:params Success:^(id json, HttpCode code) {
        NSDictionary* dic = (NSDictionary*)json;
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"code"] integerValue] == kHttpStatusOK) {
            UIAlertView * alertV = [[UIAlertView alloc] initWithTitle:nil message:@"购买成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertV showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    MainTabBarController* mainvc = [[MainTabBarController alloc] init];
                    [self.navigationController pushViewController:mainvc animated:YES];
                }
            }];

          //  [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
        }else{
            [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error) {
        
    }];
    
    
    NSLog(@"提交");
    


}
- (void)showKeyBoard:(NSNotification *)notification
{
    
    //    if (keyboardShow) {
    //        return;
    //    }
    //    NSDictionary * info = [notification userInfo];
    //    NSValue *avalue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    //    CGRect keyboardRect = [self.view convertRect:[avalue CGRectValue] fromView:nil];
    //    CGRect viewFrame = [myScrollView frame];
    //    viewFrame.size.height -= keyboardRect.size.height;
    //    myScrollView.frame = viewFrame;
    //    CGRect textFieldRect = [textView frame];
    //    [myScrollView scrollRectToVisible:textFieldRect animated:YES];
    //    keyboardShow = YES;
    //    groundView.frame = CGRectMake(0, 0, MRScreenWidth, 211);
    //    groundView.backgroundColor = [UIColor redColor];
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        sbutton.frame = CGRectMake(0, MRScreenHeight-220-49, MRScreenWidth, 49);
        sbutton.backgroundColor = [MyControl getColor:@"#31424A"];
            }];
    
}
- (void)hideKeyBoard:(NSNotification *)notification
{
    
    //  groundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, 211)];
    //    groundView.backgroundColor = [UIColor greenColor];
    [UIView animateWithDuration:0.5 animations:^{
        NSLog(@"DSFBGGH");
        sbutton.frame = CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49);
        sbutton.backgroundColor = [MyControl getColor:@"D4D4D4"];
        
    }];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [priceFiled resignFirstResponder];
    return YES;
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //groundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, 211)];
    [priceFiled resignFirstResponder];
    
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
    //[[NSNotificationCenter defaultCenter] removeObserver:self];

}



@end
