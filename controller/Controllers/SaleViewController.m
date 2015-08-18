//
//  saleViewController.m
//  zhicai
//
//  Created by perfect on 15/3/23.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "HomeModel.h"
#import "SaleViewController.h"
#import "PullingRefreshTableView.h"
#import "FTApi.h"
#import "DetaiController.h"
#import "UserManage.h"
#import "LoginViewController.h"
#import "ATLabel.h"

@interface SaleViewController ()
{
    NSDictionary * dict;
    UIButton * titBtn;
    //期限
    UILabel * lab3;
    
   //标率
    UILabel * lab5;
    
    //抢购时间
    UILabel * lab8;
    UILabel * lab10;
    
    //共多少份
    UILabel * blab;
    
//    可购买的量
    UILabel * blab1;
    
    
    /*
     
     "updays": 18,
     "soldPre": 7846,
     "finid": 401,
     "bitLimit": 31,
     "finname": "娴嬭瘯娴嬭瘯娴嬭瘯",
     "finrate": "10.00",
     "upedbuyer": 22,
     "totalPre": 8000
     
     */
    
    
    int countNum;
    int countNum1;
    int countNum2;
    int countNum3;
  
    
    UILabel *label1;
    UILabel *label2;
    UILabel *label4;
    UILabel *label5;
    
}

@end

@implementation SaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNav];
    [self createView];
    [self request];
    
}
- (void)request
{
    NSString* url = @"o/indexPageData";
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setObject:@"" forKey:@"TOKEN"];
    [params setObject:@"" forKey:@"userId"];
    [Httptool postWithURL:url Params:params Success:^(id json, HttpCode code) {
        NSDictionary* dic = (NSDictionary*)json;
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"code"] integerValue] == kHttpStatusOK) {
            self.homemodel = [HomeModel objectWithKeyValues:[dic objectForKey:@"data"]];
            [titBtn setTitle:[NSString stringWithFormat:@"%@",self.homemodel.finname] forState:UIControlStateNormal];
            lab3.text = [NSString stringWithFormat:@"%@",self.homemodel.updays];
            lab5.text = [NSString stringWithFormat:@"%@",self.homemodel.finrate];
            lab8.text = [NSString stringWithFormat:@"%@",self.homemodel.bitLimit];
            lab10.text = [NSString stringWithFormat:@"%@",self.homemodel.bitLimit];
            blab.text = [NSString stringWithFormat:@"共 %@ 份",self.homemodel.totalPre];
            blab1.text =[NSString stringWithFormat:@"%@",self.homemodel.soldPre];
        }
    } Failure:^(NSError *error) {
    
    }];

}

- (void)createNav
{
    self.navigationController.navigationBarHidden = YES;

    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:navView];

    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 30, 200, 40) font:20 Text:@"特卖推荐"];
        navlab.textAlignment = YES;
        navlab.textColor = [MyControl getColor:@"#ffffff"];
       navlab.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [navView addSubview:navlab];
}

- (void)createView
{
    
    UIView* perview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, 120)];
    perview.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:perview];
    
    blab = [MyControl createLabelFrame:CGRectMake(25, 10, MRScreenWidth-20, 30) font:20 Text:nil];
    blab.textColor = [MyControl getColor:@"#ffffff"];
    [perview addSubview:blab];
    
    UILabel *buySumLabel = [MyControl createLabelFrame:CGRectMake(25, 60, 120, 30) font:22 Text:@"购买量已达:"];
    buySumLabel.textColor = [MyControl getColor:@"#ffffff"];
   // buySumLabel.font = [UIFont boldSystemFontOfSize:22];
    [perview addSubview:buySumLabel];
    
    blab1 = [MyControl createLabelFrame:CGRectMake(MRScreenWidth/2, 45, MRScreenWidth-150, 50) font:40 Text:nil];
    blab1.textColor = [MyControl getColor:@"#ffffff"];
   // blab1.textAlignment = NSTextAlignmentCenter;
    //blab1.font = [UIFont boldSystemFontOfSize:30];
    [perview addSubview:blab1];
    
    UILabel * fLabel = [MyControl createLabelFrame:CGRectMake(blab1.frame.size.width+80, 48, 15, 50) font:17 Text:@"份"];
    fLabel.textColor = [MyControl getColor:@"#FFFFFF"];
   [perview addSubview:fLabel];
    
    UILabel *zhixuan = [MyControl createLabelFrame:CGRectMake(0, 210, MRScreenWidth, 20) font:18 Text:@"智选天下1期"];
    zhixuan.textColor = [UIColor blackColor];
    zhixuan.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:zhixuan];
    //期限
    UILabel * qixian = [MyControl createLabelFrame:CGRectMake(0, 240, MRScreenWidth, 20) font:15 Text:@"期限     天"];
    qixian.textColor = [MyControl getColor:@"#8F8F8F"];
    qixian.textAlignment = NSTextAlignmentCenter;

    [self.view addSubview:qixian];
    
    lab3 = [MyControl createLabelFrame:CGRectMake(18, 240, MRScreenWidth-18, 20) font:15 Text:nil];
    lab3.textColor = [MyControl getColor:@"669BD1"];
    lab3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab3];
    
    UILabel *snapTime = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-115)/2-15,280,100,20) font:15 Text:@"抢购时间仅剩："];
    snapTime.textColor = [MyControl getColor:@"#666D71"];
    snapTime.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:snapTime];
    
    //天
    lab8 = [MyControl createLabelFrame:CGRectMake(snapTime.frame.origin.x+90,280,20,20) font:15 Text:nil];
    lab8.textColor = [MyControl getColor:@"669BD1"];
    lab8.font = [UIFont boldSystemFontOfSize:15];
            [self.view addSubview:lab8];
    
    UILabel * lab9 = [MyControl createLabelFrame:CGRectMake(lab8.frame.origin.x+15,280,20,20) font:15 Text:@"天"];
    lab9.textColor = [MyControl getColor:@"#666D71"];
    lab9.font = [UIFont boldSystemFontOfSize:15];

    [self.view addSubview:lab9];
    
    lab10 = [MyControl createLabelFrame:CGRectMake(lab9.frame.origin.x+15,280,20,20) font:15 Text:nil];
    lab10.textColor = [MyControl getColor:@"669BD1"];
    lab10.font = [UIFont boldSystemFontOfSize:15];

    [self.view addSubview:lab10];
    
    //时
    UILabel * lab11 = [MyControl createLabelFrame:CGRectMake(lab10.frame.origin.x+16,280,20,20) font:15 Text:@"时"];
    lab11.textColor = [MyControl getColor:@"#666D71"];
    lab11.font = [UIFont boldSystemFontOfSize:15];

    [self.view addSubview:lab11];
    
    //账户资金安全由智选理财100%承保
    UIButton *btn = [MyControl createButtonFrame:CGRectMake((MRScreenWidth-230)/2, MRScreenHeight-49-55, 230, 40) Title:nil BgImageName:nil ImageName:nil Method:@selector(tbtnClick) target:self];
  //  btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    
    
    UIImageView * aimg = [MyControl createImageViewFrame:CGRectMake(0, 5, 28, 30) imageName:@"anquan"];
    [btn addSubview:aimg];
    
    UILabel * txtLab = [MyControl createLabelFrame:CGRectMake(31, 5, 210, 30) font:14 Text:@"账户资金安全由华安财险100%承保"];
            //txtLab.textAlignment = YES;
    txtLab.textColor = [MyControl getColor:@"26526C"];
    [btn addSubview:txtLab];

    

    
    [self zhuanDong];
    
    
    
}


-(void)zhuanDong
{
    
    
    
    label1 = [MyControl createLabelFrame:CGRectMake(70, 400, 80, 80) font:100 Text:nil];
    label1.text = @"0";
    [self.view addSubview:label1];
    label1.textColor = [UIColor redColor];
    
    label2 = [MyControl createLabelFrame:CGRectMake(110, 400, 80, 80) font:100 Text:nil];
    label2.text = @"0";
    label2.textColor = [UIColor redColor];
    [self.view addSubview:label2];
    
    UILabel *label3 = [MyControl createLabelFrame:CGRectMake(160, 400, 80, 80) font:100 Text:nil];
    label3.text = @".";
    label3.textColor = [UIColor redColor];
    [self.view addSubview:label3];

    label4 = [MyControl createLabelFrame:CGRectMake(180, 400, 80, 80) font:100 Text:nil];
    label4.text = @"0";
    label4.textColor = [UIColor redColor];
    [self.view addSubview:label4];

    
    
    label5 = [MyControl createLabelFrame:CGRectMake(230, 400, 80, 80) font:100 Text:nil];
    label5.text = @"0";
    label5.textColor = [UIColor redColor];
    [self.view addSubview:label5];

    UILabel *label6 = [MyControl createLabelFrame:CGRectMake(290, 410, 80, 80) font:50 Text:nil];
    label6.text = @"%";
    label6.textColor = [UIColor redColor];
    [self.view addSubview:label6];
    
    
    UIButton *buyClick = [MyControl createButtonFrame:CGRectMake(0, 360, MRScreenWidth, MRScreenHeight-360-100) Title:nil BgImageName:nil ImageName:nil Method:@selector(buyClick) target:self];
    [self.view addSubview:buyClick];
    
    
//    self.btnLab = [MyControl createLabelFrame:CGRectMake(300, 360, 30, 30) font:14 Text:nil];
//    UIButton *btn = [MyControl createButtonFrame:CGRectMake(300, 360, 30, 30) Title:@"进入" BgImageName:nil ImageName:nil Method:@selector(buyClick) target:self];
//    

//    for (int i = 0; i<4; i++) {
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80+i*50, 350, 80,80 )];
//
//        label.textAlignment =NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:100];
//        label.textColor = [UIColor redColor];
//        label.tag = 10+i;
//        label.text =@"0";
//        [self.view addSubview:label];
//        
//    }
    
 //  UILabel *
    
    //countNum = 0;
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    __block NSTimer *timer = [NSTimer timerWithTimeInterval:0.07 target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:timer forMode:UITrackingRunLoopMode];
    [timer fire];
    
    
}




- (void) countdown:(NSTimer *) timer
{
   // UILabel *labe4 = (UILabel *)[self.view viewWithTag:13];
    label5.text = [NSString stringWithFormat:@"%d",countNum];
    countNum++;
    if (countNum>=11) {
        
        label5.text = [NSString stringWithFormat:@"%d",0];
        countNum1=countNum;
        
      //  UILabel *labe3 = (UILabel *)[self.view viewWithTag:12];
        label4.text = [NSString stringWithFormat:@"%d",countNum1-10];
        countNum1++;
        
        //第2个
        if (countNum>19) {
            
            label4.text = [NSString stringWithFormat:@"%d",0];
            countNum2=countNum1;
            
           // UILabel *labe2 = (UILabel *)[self.view viewWithTag:11];
            label2.text = [NSString stringWithFormat:@"%d",countNum2-20];
            countNum2++;
            //第1个
            
            if (countNum>28) {
                
                label2.text = [NSString stringWithFormat:@"%d",2];
                countNum3=countNum2;
                
                //UILabel *labe1 = (UILabel *)[self.view viewWithTag:10];
                //                labe1.text = [NSString stringWithFormat:@"%d",countNum2-29];
                //                countNum3++;
                label1.text = [NSString stringWithFormat:@"%d ",1];
                [timer invalidate];
                timer =nil;
            }
            
        }
        
    }
    
    
    
}


- (void)titClick
{
    NSLog(@"智选天下1期");

}

- (void)tbtnClick
{

    NSLog(@"fsrtrhuy");

}
- (void)buyClick
{
    NSLog(@"sbvo");
    
    
    
   // [UserManage isDidLogin]
    
//    if (![[NSUserDefaults standardUserDefaults]objectForKey:CURRENT_USER_PHONE])
//    {
//        NSLog(@"%@",CURRENT_USER_PHONE);
//        loginViewController * login = [[loginViewController alloc]init];
//         self.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:login animated:YES];
////        [self presentViewController:login animated:YES completion:^{
////            
////        }];
//        
//    }else{
//        
//    DetaiController * detail = [[DetaiController alloc]init];
//    [self.navigationController pushViewController:detail animated:YES];
//    
//    }
    
    
    DetaiController * detail = [[DetaiController alloc]init];
    detail.isSalevc = YES;
    detail.homemodel = self.homemodel;
   [self.navigationController pushViewController:detail animated:YES];
    
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
