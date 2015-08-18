//
//  addBankView.m
//  zhicai
//
//  Created by perfect on 15/4/7.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "BankCardModel.h"
#import "BuyController.h"
#import "AddBankView.h"
#import "SelectBankViewController.h"
@interface AddBankView ()<UITextFieldDelegate>
{
    UIView * bankView;
    UITextField * nameFiled;
    UITextField * shenfenFiled;
    UITextField * kaFiled;
    UIButton * bangdingBtn;
    UIScrollView * myScrollView;

}

@end

@implementation AddBankView

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.mycardarr = [[NSMutableArray alloc]init];
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
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"添加银行卡"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
    
   UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    // backBtn.backgroundColor = [UIColor redColor];
    [navView addSubview:backBtn];
    
    
}
- (void)createView
{
    
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, MRScreenHeight-64)];
    [myScrollView setContentSize:CGSizeMake(MRScreenWidth, MRScreenHeight+100)];
    myScrollView.userInteractionEnabled = YES;
    //myScrollView.backgroundColor = [UIColor redColor];
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.bounces = YES;
     [self.view addSubview:myScrollView];
    
    bankView = [[UIView alloc]initWithFrame:CGRectMake(0, 64-64, MRScreenWidth, 285)];
    bankView.userInteractionEnabled = YES;
    bankView.backgroundColor = [MyControl getColor:@"EDEDED"];
  //  bankView.backgroundColor = [UIColor redColor];
    [myScrollView addSubview:bankView];
    
    UILabel * infoLab = [MyControl createLabelFrame:CGRectMake(16, 0, 200, 26) font:11 Text:@"持卡人信息"];
    infoLab.textColor = [MyControl getColor:@"8E8E8E"];
    [bankView addSubview:infoLab];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 26, MRScreenWidth, 88)];
    view.userInteractionEnabled = YES;
    [bankView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * userLab = [MyControl createLabelFrame:CGRectMake(16, 0, 30, 44) font:15 Text:@"姓名"];
    userLab.textAlignment = YES;
    [view addSubview:userLab];
    
    nameFiled = [MyControl createTextFieldFrame:CGRectMake(75, 0, self.view.frame.size.width-80, 44) Placeholder:@"请输入持卡人姓名" leftView:nil rightView:nil BgImageName:nil font:15];
    nameFiled.delegate = self;
    //nameFiled.returnKeyType = UIReturnKeyDefault;
    nameFiled.keyboardType = UIReturnKeyDefault;
    //   userFiled.returnKeyType = UIReturnKeyDefault;
    [view addSubview:nameFiled];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, MRScreenWidth, 1)];
    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [view addSubview:lineView];
    
    UILabel * pwdLab = [MyControl createLabelFrame:CGRectMake(16, 44, 50, 44) font:15 Text:@"身份证"];
    //pwdLab.textAlignment = YES;
    [view addSubview:pwdLab];
    
    shenfenFiled = [MyControl createTextFieldFrame:CGRectMake(75, 44, 150, 44) Placeholder:@"请输入持卡人身份证号" leftView:nil rightView:nil BgImageName:nil font:15];
   // shenfenFiled.secureTextEntry = YES;//密码遮掩
    shenfenFiled.delegate = self;
    //shenfenFiled.returnKeyType = UIReturnKeyGo;
   // shenfenFiled.keyboardType = UIKeyboardTypeAlphabet;
    shenfenFiled.returnKeyType = UIReturnKeyDone;
    [view addSubview:shenfenFiled];
    
    UILabel * inLab = [MyControl createLabelFrame:CGRectMake(0, 114, MRScreenWidth, 20) font:11 Text:@"请填写本人真实信息，核实后不可更改"];
    inLab.textColor = [MyControl getColor:@"8E8E8E"];
    inLab.textAlignment = YES;
    [bankView addSubview:inLab];
    
    UILabel * bankInfoLab = [MyControl createLabelFrame:CGRectMake(16, 164, 80, 27) font:11 Text:@"银行卡信息"];
   // bankInfoLab.backgroundColor = [UIColor redColor];
    bankInfoLab.textColor = [MyControl getColor:@"8E8E8E"];
    [bankView addSubview:bankInfoLab];

    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 194, MRScreenWidth, 88)];
    [bankView addSubview:view1];
    view1.backgroundColor = [UIColor whiteColor];
    UILabel * bankLab = [MyControl createLabelFrame:CGRectMake(16, 0, 30, 44) font:15 Text:@"银行"];
    bankLab.textAlignment = YES;
    [view1 addSubview:bankLab];
    
//    nameFiled = [MyControl createTextFieldFrame:CGRectMake(60, 0, self.view.frame.size.width-80, 44) Placeholder:@"请输入持卡人姓名" leftView:nil rightView:nil BgImageName:nil font:15];
//    nameFiled.delegate = self;
//    nameFiled.returnKeyType = UIReturnKeyGo;
//    nameFiled.keyboardType = UIKeyboardTypeNumberPad;//数字键盘
//    //   userFiled.returnKeyType = UIReturnKeyDefault;
//    [view1 addSubview:nameFiled];
    
    UIButton * selBankBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    selBankBtn.frame = CGRectMake(60, 0, MRScreenWidth-60, 44);
    //selBankBtn.backgroundColor = [UIColor greenColor];
    [selBankBtn addTarget:self action:@selector(selClick) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:selBankBtn];
    
    self.bank = [MyControl createLabelFrame:CGRectMake(0, 0, 80, 44) font:15 Text:@""];
    self.bank.textColor = [MyControl getColor:@"8E8E8E"];
    [selBankBtn addSubview:self.bank];
    UIImageView * img = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7-60, (44-11)/2+3, 7, 11) imageName:@"dxiayib@1x.png"];
    
    [selBankBtn addSubview:img];
    
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 43, MRScreenWidth, 1)];
    lineView3.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [view1 addSubview:lineView3];
    
    UILabel * kaLab = [MyControl createLabelFrame:CGRectMake(16, 44, 30, 44) font:15 Text:@"卡号"];
    kaLab.textAlignment = YES;
    [view1 addSubview:kaLab];
    
    kaFiled = [MyControl createTextFieldFrame:CGRectMake(60, 44, 150, 44) Placeholder:@"请输入银行卡号" leftView:nil rightView:nil BgImageName:nil font:15];
   // kaFiled.secureTextEntry = YES;//密码遮掩
    kaFiled.delegate = self;
    kaFiled.returnKeyType = UIReturnKeyGo;
    kaFiled.keyboardType = UIKeyboardTypeNumberPad;//数字键盘
    [view1 addSubview:kaFiled];
    
    bangdingBtn = [MyControl createButtonFrame:CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49) Title:@"绑定" BgImageName:nil ImageName:nil Method:@selector(sureClick) target:self];
    bangdingBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [bangdingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bangdingBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    bangdingBtn.backgroundColor = [MyControl getColor:@"D4D4D4"];
    [self.view addSubview:bangdingBtn];

    
}
-(void)sureClick
{

    NSString* url = @"u/bundCreditCard";
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:gAppDelegate.userModel.userId forKey:@"userId"];
    [params setObject:self.bankid forKey:@"bankId"];
    [params setObject:kaFiled.text forKey:@"cardNum"];
    [params setObject:gAppDelegate.userModel.mobilePhone forKey:@"mobile"];
    [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:kLoginTokenIdentifier] forKey:@"TOKEN"];
    [params setObject:nameFiled.text forKey:@"idcardName"];
    [params setObject:shenfenFiled.text forKey:@"idcardNum"];
    [Httptool postWithURL:url Params:params Success:^(id json, HttpCode code) {
        NSDictionary* dic = (NSDictionary*)json;
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"code"] integerValue] == kHttpStatusOK) {
           // self.mybankcarkmodel = [BankCardModel objectWithKeyValues:[[[dic objectForKey:@"data"] objectForKey:@"cards"] lastObject]];
            
            BuyController* buyvc = [[BuyController alloc] init];
//            buyvc.bankname = self.bank.text;
//            buyvc.cardNO = [kaFiled.text substringFromIndex:kaFiled.text.length-4];
            
            //            buyvc = self.navigationController.childViewControllers[2];
            //            buyvc.mybankcmodel = self.mycardarr.lastObject;
            // buyvc.bankname = self.bank.text;
            
            [self.navigationController pushViewController:buyvc animated:YES];

         }else{
            [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error) {
        
    }];
    NSLog(@"绑定");
    

}

- (void)selClick
{

    NSLog(@"选择银行卡");
    SelectBankViewController * selectbankvc = [[SelectBankViewController alloc]init];
    selectbankvc.addbank = self;
    [self.passmodel passModel:selectbankvc.mybankmodel];
    [self.navigationController pushViewController:selectbankvc animated:YES];
    
    


}

-(void)passModel:(BankModel*) bankmodel{
    self.bank.text = bankmodel.bankname;
}

- (void)addClick
{
    
    AddBankView * add = [[AddBankView alloc]init];
    [self.navigationController pushViewController:add animated:YES];
    
    
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark textFiledDelegate
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
    
    if (iPhone4)
    {
        [UIView animateWithDuration:0.5 animations:^{
//            bankView.center =CGPointMake(bankView.center.x, bankView.center.y-160);
            // groundView.backgroundColor = [UIColor redColor];
            bangdingBtn.frame = CGRectMake(0, MRScreenHeight-250-49, MRScreenWidth, 49);
            bangdingBtn.backgroundColor = [MyControl getColor:@"#31424A"];
        }];

    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
//            bankView.center =CGPointMake(bankView.center.x, bankView.center.y-100);
            // groundView.backgroundColor = [UIColor redColor];
            bangdingBtn.frame = CGRectMake(0, MRScreenHeight-260-49, MRScreenWidth, 49);
            bangdingBtn.backgroundColor = [MyControl getColor:@"#31424A"];
        }];
    }
}
- (void)hideKeyBoard:(NSNotification *)notification
{
    
    //  groundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, 211)];
    //    groundView.backgroundColor = [UIColor greenColor];
        [UIView animateWithDuration:0.5 animations:^{
            NSLog(@"DSFBGGH");
           // bankView.center=CGPointMake(self.view.center.x, self.view.center.y-20);
            // groundView.backgroundColor = [UIColor greenColor];
           // bankView.frame = CGRectMake(0, 64, MRScreenWidth, 285);
            bangdingBtn.frame = CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49);
            bangdingBtn.backgroundColor = [MyControl getColor:@"D4D4D4"];
        }];

    
}

//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//}

//UITextField * nameFiled;
//UITextField * shenfenFiled;
//UITextField * kaFiled;
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [nameFiled resignFirstResponder];
    [shenfenFiled resignFirstResponder];
    [kaFiled resignFirstResponder];
    return YES;
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //groundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, 211)];
    [nameFiled resignFirstResponder];
    [shenfenFiled resignFirstResponder];
    [kaFiled resignFirstResponder];
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
