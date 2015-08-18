//
//  productInfoController.m
//  zhicai
//
//  Created by perfect on 15/4/9.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "productInfoController.h"
#import "FTApi.h"
@interface productInfoController ()
{
    UILabel * navlab;
    UILabel  * buyTimeLab;
    UILabel * expiratTimeLab;
    UILabel * benjinLab;
    UILabel * nowInsuranceLab;
    UILabel * expiratInsuranceLab;
    
}
@end

@implementation productInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNav];
    [self createView];
    [self request];
}
- (void)createNav
{
    self.view.backgroundColor = [MyControl getColor:@"EDEDED"];
    self.navigationController.navigationBarHidden = YES;
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
     navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:nil];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"010D12"];
    [navView addSubview:navlab];
    
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    [navView addSubview:backBtn];
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 63, MRScreenWidth-30, 1)];
    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [navView addSubview:lineView];
}

- (void)request
{
    NSString * str =[NSString stringWithFormat:API_MyZCDetail];
    str  = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [FTApi requestWithMethod:@"Get" withPath:str withParams:nil  complate:^(id responseObject,NSError*error){
        if (error) {
            NSLog(@"============error==%@",error);
            
        }else{
            NSLog(@"-----respon==%@",responseObject);
            navlab.text = [responseObject objectForKey:@"tradeTit"];
            buyTimeLab.text = [NSString stringWithFormat:@"购买时间：%@",[responseObject objectForKey:@"buyTime"]];
            expiratTimeLab.text = [NSString stringWithFormat:@"到期时间：%@",[responseObject objectForKey:@"expiratTime"]];
            benjinLab.text = [responseObject objectForKey:@"benjin"];
            nowInsuranceLab.text = [responseObject objectForKey:@"nowInsurance"];
            expiratInsuranceLab.text = [NSString stringWithFormat:@"%@%",[responseObject objectForKey:@"expiratInsurance"]];
            
        }
    }];
    
}



-(void)createView
{
 //  白蓝@1x.png 285*238
//    UIImageView * image = [MyControl createImageViewFrame:CGRectMake(12, imageView.frame.size.height-64-8-190, MRScreenWidth-12*2, 190) imageName:@"konianbai@1x.png"];
//    [imageView addSubview:image];
    UIImageView * image = [MyControl createImageViewFrame:CGRectMake(13, 80, MRScreenWidth-13*2, 185) imageName:@"蓝白@1x.png"];
    [self.view addSubview:image];
   
     buyTimeLab = [MyControl createLabelFrame:CGRectMake(10, 0, 140, 25) font:12 Text:nil];
    buyTimeLab.textColor = [UIColor whiteColor];
    [image addSubview:buyTimeLab];
    
     expiratTimeLab = [MyControl createLabelFrame:CGRectMake(image.frame.size.width-10-140, 0, 140, 25) font:12 Text:nil];
    expiratTimeLab.textColor = [UIColor whiteColor];
    expiratTimeLab.textAlignment = NSTextAlignmentRight;
    [image addSubview:expiratTimeLab];
    // lab2.backgroundColor = [UIColor redColor];
    
    UILabel * lab3 = [MyControl createLabelFrame:CGRectMake(10, 25, 60, 40) font:12 Text:@"本金"];
    lab3.textColor = [MyControl getColor:@"#31424A"];
    [image addSubview:lab3];
    
     benjinLab = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-10-100, 25, 80, 40) font:12 Text:nil];
    benjinLab.textColor = [MyControl getColor:@"#8E8E8E"];
    benjinLab.textAlignment = NSTextAlignmentRight;
    [image addSubview:benjinLab];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 64, image.frame.size.width, 1)];
    line.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [image addSubview:line];
    
    UILabel * lab5 = [MyControl createLabelFrame:CGRectMake(10, 25+40, 60, 40) font:12 Text:@"现收益"];
    lab5.textColor = [MyControl getColor:@"#31424A"];
    [image addSubview:lab5];
    
    nowInsuranceLab = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-10-100, 25+40, 80, 40) font:12 Text:nil];
    nowInsuranceLab.textColor = [MyControl getColor:@"#8E8E8E"];
    nowInsuranceLab.textAlignment = NSTextAlignmentRight;
    [image addSubview:nowInsuranceLab];
    
    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 64+40, image.frame.size.width, 1)];
    line1.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [image addSubview:line1];
    

    UILabel * lab7 = [MyControl createLabelFrame:CGRectMake(10, 25+80, 100, 40) font:12 Text:@"预计年化收益"];
    lab7.textColor = [MyControl getColor:@"#31424A"];
    [image addSubview:lab7];
    
     expiratInsuranceLab = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-10-100, 25+80, 80, 40) font:12 Text:nil];
    expiratInsuranceLab.textColor = [MyControl getColor:@"#8E8E8E"];
    expiratInsuranceLab.textAlignment = NSTextAlignmentRight;
    [image addSubview:expiratInsuranceLab];
    
    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 64+80, image.frame.size.width, 1)];
    line2.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [image addSubview:line2];
    
    UIButton * infoBtn = [MyControl createButtonFrame:CGRectMake(0, 64+80, image.frame.size.width, 40) Title:nil BgImageName:nil ImageName:nil Method:@selector(infoClick) target:self];
    [image addSubview:infoBtn];
    
    UILabel * lab9 = [MyControl createLabelFrame:CGRectMake(10, 0, 80, 40) font:12 Text:@"投资详情"];
    lab9.textColor = [MyControl getColor:@"#31424A"];
    [infoBtn addSubview:lab9];
    
    UIImageView * img2 = [MyControl createImageViewFrame:CGRectMake(image.frame.size.width-16, (40-11)/2+3, 7, 11) imageName:@"dxiayib@1x.png"];
    [infoBtn addSubview:img2];

}


- (void)infoClick
{

    NSLog(@"投资详情");

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
