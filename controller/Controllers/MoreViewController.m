//
//  moreViewController.m
//  zhicai
//
//  Created by perfect on 15/3/23.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "ProintroduceTableViewController.h"
#import "MoreViewController.h"
#import "FTApi.h"
#import "PullingRefreshTableView.h"
#import "IntroduceViewController.h"
#import "SetViewController.h"
#import "ContactViewController.h"
#import "Set1ViewController.h"
#import "UserManage.h"
#import "LoginViewController.h"
#import "FTApi.h"

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    PullingRefreshTableView * atableView;
    NSArray * dataArr;
    UITableView * mytableView;
    
}

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [MyControl getColor:@"#EDEDED"];
    
    [self createNav];
    [self createTableView];

  
}
- (void)createNav
{

    self.navigationController.navigationBarHidden = YES;
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"更多"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];

}


- (void)createTableView
{

    mytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, MRScreenHeight-64) style:UITableViewStyleGrouped];
    mytableView.delegate = self;
    mytableView.dataSource = self;
    mytableView.backgroundColor = [UIColor clearColor];
   // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   mytableView.separatorColor = [UIColor clearColor];//改变tableView的背景色，也就是去除去除下面的横线，添加自己设置的lineView
    [self.view addSubview:mytableView];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0==section)
    {
        return 1;
    }
    else
    {
        return 2;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * strId = @"ID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strId];
    }
    if (indexPath.section == 0)
    {
        UIImageView * img = [MyControl createImageViewFrame:CGRectMake(16, 10, 24, 24) imageName:@"2leimu1.png"];
        [cell.contentView addSubview:img];
        UILabel * lab = [MyControl createLabelFrame:CGRectMake(16+24+10, 0, 80, 44) font:15 Text:@"公司介绍"];
        lab.textColor = [MyControl getColor:@"#31424A"];
        [cell.contentView addSubview:lab];
        
        UIImageView * img2 = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, (40-11)/2+3, 7, 11) imageName:@"dxiayib@1x.png"];
        [cell.contentView addSubview:img2];
        
    }
    else if(indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
            {
            
            UIImageView * img = [MyControl createImageViewFrame:CGRectMake(16, 10, 24, 24) imageName:@"2leimu2.png"];
                [cell.contentView addSubview:img];
                UILabel * lab = [MyControl createLabelFrame:CGRectMake(16+24+10, 0, 80, 44) font:15 Text:@"设置"];
                lab.textColor = [MyControl getColor:@"#31424A"];

                [cell.contentView addSubview:lab];
                
                UIImageView * img2 = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, (40-11)/2+3, 7, 11) imageName:@"dxiayib@1x.png"];
                [cell.contentView addSubview:img2];
                UIView * cellLineView = [[UIView alloc]initWithFrame:CGRectMake(15, 43, MRScreenWidth-15*2, 1)];
                cellLineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
                [cell.contentView addSubview:cellLineView];
            }
                break;
            case 1:
            {
                
             UIImageView * img = [MyControl createImageViewFrame:CGRectMake(16, 10, 24, 24) imageName:@"2leimu3.png"];
                [cell.contentView addSubview:img];
                UILabel * lab = [MyControl createLabelFrame:CGRectMake(16+24+10, 0, 80, 44) font:15 Text:@"联系我们"];
                lab.textColor = [MyControl getColor:@"#31424A"];

                [cell.contentView addSubview:lab];
                
                UIImageView * img2 = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, (40-11)/2+3, 7, 11) imageName:@"dxiayib@1x.png"];
                [cell.contentView addSubview:img2];

            }
                break;
            default:
                break;
        }
    }
    
    
   // cell.textLabel.text = dataArr[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        //ProintroduceTableViewController* proIntroducevc = [[ProintroduceTableViewController alloc]init];
    
        IntroduceViewController * intro = [[IntroduceViewController alloc]init];
        [self.navigationController pushViewController:intro animated:YES];
    }
    else if (indexPath.section == 1)
    {
    switch (indexPath.row) {
    case 0:
        {
            
            
            if (!gAppDelegate.userModel.mobilePhone)
            {
                LoginViewController * login = [[LoginViewController alloc]init];
                //self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }else{
                
                SetViewController * set = [[SetViewController alloc]init];
                [self.navigationController pushViewController:set animated:YES];
                
            }

//            SetViewController * set = [[SetViewController alloc]init];
//            [self.navigationController pushViewController:set animated:YES];
            

        }
            break;
    case 1:
        {
        
            ContactViewController * contact = [[ContactViewController alloc]init];
            [self.navigationController pushViewController:contact animated:YES];
        }
       
            break;
    }

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 44;

}

@end
