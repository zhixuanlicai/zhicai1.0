//
//  recordInfoView.m
//  zhicai
//
//  Created by perfect on 15/4/9.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "RecordInfoView.h"
#import "ProductInfoController.h"
#import "DetaiController.h"
#import "FTApi.h"
@interface RecordInfoView ()
{
    UILabel * sucessLab;
    UILabel * timeLab;
    UILabel * nameLab;
    UILabel * lab2;
    UILabel * lab4;
    UILabel * lab6;
}
@end

@implementation RecordInfoView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
    [self createView];
    [self request];
    
}
- (void)createNav
{
   // self.view.backgroundColor = [MyControl getColor:@"EDEDED"];
    self.navigationController.navigationBarHidden = YES;
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"交易记录详情"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
    
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    [navView addSubview:backBtn];
//    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 63, MRScreenWidth-30, 1)];
//    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
//    [navView addSubview:lineView];
    
}

- (void)createView
{

    UIView * sucessView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, 77)];
    [self.view addSubview:sucessView];
    
   UIImageView * recordImg = [MyControl createImageViewFrame:CGRectMake(16, (77-30)/2, 30, 30) imageName:@"xiaowancheng@1x.png"];
    [sucessView addSubview:recordImg];
    
     sucessLab = [MyControl createLabelFrame:CGRectMake(16+30+14, 0, 100,77) font:21 Text:nil];
    sucessLab.textColor = [MyControl getColor:@"#31424A"];
    [sucessView addSubview:sucessLab];
    
    
    timeLab = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-140, 0, 140, 77) font:12 Text:nil];
    timeLab.textColor = [MyControl getColor:@"#8cc3ea"];
    timeLab.textAlignment = NSTextAlignmentRight;
    [sucessView addSubview:timeLab];
    //timeLab.backgroundColor = [UIColor redColor];
    
    UIView * celline = [[UIView alloc]initWithFrame:CGRectMake(16, 76, MRScreenWidth-16*2, 1)];
    celline.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [sucessView addSubview:celline];

    
    UIButton * productBtn =[MyControl createButtonFrame:CGRectMake(0, 141, MRScreenWidth, 62) Title:nil BgImageName:nil ImageName:nil Method:@selector(btnClick) target:self];
    [self.view addSubview:productBtn];
    
    UILabel * productLab= [MyControl createLabelFrame:CGRectMake(16, 18, 100, 44) font:15 Text:@"产品名称"];
    productLab.textColor = [MyControl getColor:@"#31424A"];
    [productBtn addSubview:productLab];
    
     nameLab =[MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-10-80, 18, 80, 44) font:12 Text:nil];
    nameLab.textColor = [MyControl getColor:@"8E8E8E"];
   // nameLab.textAlignment = NSTextAlignmentRight;
    [productBtn addSubview:nameLab];
    
    UIImageView * img = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, 33, 7, 11) imageName:@"dxiayib@1x.png"];
    //img.backgroundColor = [UIColor purpleColor];
    [productBtn addSubview:img];

    UIView * celline1 = [[UIView alloc]initWithFrame:CGRectMake(16, 202, MRScreenWidth-16*2, 1)];
    celline1.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [self.view addSubview:celline1];
    
    
    // 购买期限
    UILabel * lab1= [MyControl createLabelFrame:CGRectMake(16, 203, 100, 44) font:15 Text:@"购买期限"];
    lab1.textColor = [MyControl getColor:@"#31424A"];
    [self.view addSubview:lab1];
    
    lab2 =[MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-40, 203, 40, 44) font:12 Text:nil];
    lab2.textColor = [MyControl getColor:@"8E8E8E"];
     lab2.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:lab2];

    UIView * celline2 = [[UIView alloc]initWithFrame:CGRectMake(16, 246, MRScreenWidth-16*2, 1)];
    celline2.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [self.view addSubview:celline2];
    
    //购买金额
    
    UILabel * lab3= [MyControl createLabelFrame:CGRectMake(16, 247, 100, 44) font:15 Text:@"购买金额"];
    lab3.textColor = [MyControl getColor:@"#31424A"];
    [self.view addSubview:lab3];
    
    lab4 =[MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-100, 247, 100, 44) font:12 Text:nil];
    lab4.textColor = [MyControl getColor:@"8E8E8E"];
    lab4.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:lab4];
    
    UIView * celline3 = [[UIView alloc]initWithFrame:CGRectMake(16, 246+44, MRScreenWidth-16*2, 1)];
    celline3.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [self.view addSubview:celline3];
    
    //预计收益
    
    UILabel * lab5= [MyControl createLabelFrame:CGRectMake(16, 247+44, 100, 44) font:15 Text:@"预计收益"];
    lab5.textColor = [MyControl getColor:@"#31424A"];
    [self.view addSubview:lab5];
    
     lab6 =[MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-100, 247+44, 100, 44) font:12 Text:nil];
    lab6.textColor = [MyControl getColor:@"8E8E8E"];
    lab6.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:lab6];
    
    UIView * celline4 = [[UIView alloc]initWithFrame:CGRectMake(16, 246+44*2, MRScreenWidth-16*2, 1)];
    celline4.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [self.view addSubview:celline4];
    
}
- (void)request
{
    NSString* url = @"u/userBitfinancingDetail";
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:kLoginTokenIdentifier] forKey:@"TOKEN"];
    [params setObject:self.recordmodel.bitId forKey:@"bitId"];
    [Httptool postWithURL:url Params:params Success:^(id json, HttpCode code) {
        NSDictionary* dic = (NSDictionary*)json;
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"code"] integerValue] == kHttpStatusOK) {
            self.myproList = [MyProductsListModel objectWithKeyValues:[dic objectForKey:@"data"]];
        }
        sucessLab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
        timeLab.text = [NSString stringWithFormat:@"%@",self.myproList.startDate];
        nameLab.text = [NSString stringWithFormat:@"%@",self.myproList.finname];
        lab2.text = [NSString stringWithFormat:@"%@天",self.myproList.bitLimit];
        lab4.text = [NSString stringWithFormat:@"%@元",self.myproList.bitAmount];
        lab6.text = [NSString stringWithFormat:@"%@元",self.myproList.profit];
        
    } Failure:^(NSError *error) {
        
    }];
//    [FTApi requestWithMethod:@"Get" withPath:API_ProductRecDetail withParams:nil complate:^(id response, NSError *error) {
//        if (error) {
//            NSLog(@"error = %@",error);
//        }else{
////            UILabel * sucessLab;
////            UILabel * timeLab;
////            UILabel * nameLab;
////            UILabel * lab2;
////            UILabel * lab4;
////            UILabel * lab6;
//        
//            NSLog(@"RecDetailResponse = %@",response);
//            
//            sucessLab.text = [response objectForKey:@"trade"];
//            timeLab.text = [response objectForKey:@"detailTime"];
//            nameLab.text = [response objectForKey:@"tradeTit"];
//            lab2.text = [NSString stringWithFormat:@"%@天",[response objectForKey:@"timeDay"]];
//            lab4.text = [NSString stringWithFormat:@"%@元",[response objectForKey:@"benjin"]];
//            lab6.text = [NSString stringWithFormat:@"%@元",[response objectForKey:@"expectCome"]];
//        }
//    }];
}

- (void)btnClick
{

    NSLog(@"产品详细");
    
    DetaiController * detail = [[DetaiController alloc]init];
    
    NSString* url = @"o/getSingleProfit";
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:self.myproList.finId forKey:@"finId"];
    [Httptool postWithURL:url Params:params Success:^(id json, HttpCode code) {
        NSDictionary* dic = (NSDictionary*) json;
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"code"] integerValue]== kHttpStatusOK) {
           // detail.promodel = [productModel objectWithKeyValues:[dic objectForKey:@"data"]];
            detail.navlab.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"finname"]];
            detail.tLab.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"bitLimit"]];
            detail.glab.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"finrate"]];
            detail.personLab.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"upedbuyer"]];
            detail.canLab.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"soldPre"]];
        }
    } Failure:^(NSError *error) {
        
    }];
    
    [self.navigationController pushViewController:detail animated:YES];

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
