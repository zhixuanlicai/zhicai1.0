//
//  myMoneyViewController.m
//  zhicai
//
//  Created by perfect on 15/3/23.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "MyProductsListModel.h"
#import "RecordInfoView.h"

#import "MyMoneyViewController.h"
#import "LoginViewController.h"
#import "PullingRefreshTableView.h"
#import "MyMoneyCell.h"
#import "InfoController.h"
#import "RecordController.h"
#import "productInfoController.h"
#import "UserManage.h"
#import "FTApi.h"
#import "MyMoneyModel.h"
#import "SVProgressHUD.h"
#import "FTModel.h"
@interface MyMoneyViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    
    UIImageView * imageView;//登录背景图
    UIView * headerView;
    BOOL refreshing;
    NSInteger page;
    NSInteger totalPage;
    UIView * footView;
    UILabel * mLab;
    UILabel * pLab;
    
    NSMutableArray * dataArr;
//    myMoneyModel * model;
       NSMutableDictionary * dict;
}

@property(nonatomic,retain)PullingRefreshTableView * aTableView;


@end

@implementation MyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myarr = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    
  //  self.view.backgroundColor = [UIColor redColor];
    
    dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    [self createNav];
    [self createHeadView];
    [self createTableView];
    NSLog(@"333333333333%@",[[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_USER_PHONE]);

}

- (void)createNav
{
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, MRScreenHeight)];
    imageView.userInteractionEnabled = YES;
    // [self.view addSubview:imageView];
    
//    UIButton * start = [MyControl createButtonFrame:CGRectMake(0, imageView-50, self.view.frame.size.width-20,40) Title:@"开始赚钱" BgImageName:nil ImageName:nil Method:@selector(click) target:self];
//   start.backgroundColor = [UIColor redColor];
//   [imageView addSubview:start];
    
    
   // self.view.backgroundColor = [MyControl getColor:@"EDEDED"];
    self.navigationController.navigationBarHidden = YES;
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"我的资产"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
    
//    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 63, MRScreenWidth-30, 1)];
//    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
//    [self.view addSubview:lineView];
    
    UIButton * infoBtn = [MyControl createButtonFrame:CGRectMake(MRScreenWidth-22-16, (64-20)/2+7, 22, 20) Title:nil BgImageName:nil ImageName:@"xinxi.png" Method:@selector(infoClick) target:self];
    [navView addSubview:infoBtn];
    
    
}
- (void)infoClick
{

    NSLog(@"消息");
    InfoController * info = [[InfoController alloc]init];
    [self.navigationController pushViewController:info animated:YES];

}

- (void)createHeadView
{

    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, 360-64)];
    headerView.backgroundColor = [UIColor whiteColor];
   // headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:headerView];
    
    UILabel * tolLab =[MyControl createLabelFrame:CGRectMake(15, 64-64, 120, 34) font:15 Text:@"总资产"];
    tolLab.textColor = [MyControl getColor:@"#31424A"];
   // tolLab.backgroundColor = [UIColor redColor];
    [headerView addSubview:tolLab];
 
    mLab = [MyControl createLabelFrame:CGRectMake(27, 98-64, 200, 90) font:70 Text:nil];
    mLab.textColor = [MyControl getColor:@"#3E535E"];
    //mLab.backgroundColor = [UIColor greenColor];
    [headerView addSubview:mLab];
    
    UIButton * seeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    seeBtn.frame =CGRectMake(MRScreenWidth-16-120, 200-64, 120, 25);
    [seeBtn setTitle:@"查看交易记录" forState:UIControlStateNormal];
    [seeBtn addTarget:self action:@selector(seeClick) forControlEvents:UIControlEventTouchUpInside];
    [seeBtn setTitleColor:[MyControl getColor:@"#8cc3ea"] forState:UIControlStateNormal];
    seeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    seeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
   // seeBtn.backgroundColor = [UIColor purpleColor];
    [headerView addSubview:seeBtn];
    
    
    UIImageView * img2 = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, 200-57, 7, 11) imageName:@"dxiayib@1x.png"];
    [headerView addSubview:img2];
    
    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake(15, 234-64, MRScreenWidth-15*2, 1)];
    lineView1.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [headerView addSubview:lineView1];
    
    UILabel * getLab =[MyControl createLabelFrame:CGRectMake(15, 235-64, 120, 34) font:15 Text:@"总收益"];
    getLab.textColor = [MyControl getColor:@"#31424A"];
   // getLab.backgroundColor = [UIColor redColor];
    [headerView addSubview:getLab];
    
     pLab = [MyControl createLabelFrame:CGRectMake(27, 275-64, 200, 50) font:40 Text:nil];
    pLab.textColor = [MyControl getColor:@"#3E535E"];
   // pLab.backgroundColor = [UIColor greenColor];
    [headerView addSubview:pLab];
    
    UIView * cView = [[UIView alloc]initWithFrame:CGRectMake(0, 335-64, MRScreenWidth, 24)];
    cView.backgroundColor= [MyControl getColor:@"#EDEDED"];
    [headerView addSubview:cView];
    UIView * lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 334-64, MRScreenWidth, 1)];
    lineView2.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [headerView addSubview:lineView2];
    
    UIView * lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 359-64, MRScreenWidth, 1)];
    lineView3.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [headerView addSubview:lineView3];
    
    
    NSArray * titleArr = @[@"产品名称",@"本金",@"已购买天数",@"收益"];
    
    for (int i = 0; i<titleArr.count; i++) {
        UILabel * cLab = [MyControl createLabelFrame:CGRectMake(MRScreenWidth/4*i,0,MRScreenWidth/4,24) font:11 Text:titleArr[i]];
        cLab.textAlignment = NSTextAlignmentCenter;
        //cLab.backgroundColor = [UIColor redColor];
        cLab.textColor = [MyControl getColor:@"#8E8E8E"];
        [cView addSubview:cLab];
    }
}

- (void)createTableView
{
    self.aTableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, MRScreenHeight-29-64)];
    self.aTableView.backgroundColor = [UIColor clearColor];
    self.aTableView.dataSource = self;
    self.aTableView.delegate = self;
    self.aTableView.pullingDelegate = self;
    self.aTableView.tableHeaderView = headerView;
    self.aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.aTableView.rowHeight = 40;
    [self.view addSubview:self.aTableView];
    [self.aTableView launchRefreshing];
    
    
    self.aTableView.tableFooterView = nil;
    //230
    
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 50)];
    footView.backgroundColor = [UIColor whiteColor];
    
    //footView.backgroundColor = [UIColor greenColor];
    self.aTableView.tableFooterView  = footView;
    UIButton * totoalBtn =[MyControl createButtonFrame:CGRectMake((MRScreenWidth-217)/2, 5, 217, 40) Title:nil BgImageName:nil ImageName:nil Method:@selector(tbtnClick) target:self];
    //totoalBtn.backgroundColor = [UIColor redColor];
    [footView addSubview:totoalBtn];
    
    UIImageView * aimg = [MyControl createImageViewFrame:CGRectMake(0, 5, 28, 29) imageName:@"anquan@1x.png"];
    [totoalBtn addSubview:aimg];
    
    UILabel * txtLab = [MyControl createLabelFrame:CGRectMake(30, 0, 200, 40) font:12 Text:@"账户资金安全由华安财险100%承保"];
    //txtLab.textAlignment = YES;
    txtLab.textColor = [MyControl getColor:@"26526C"];
    [totoalBtn addSubview:txtLab];
 
    
    
    
    imageView = [MyControl createImageViewFrame:CGRectMake(0, 64, MRScreenWidth, MRScreenHeight-64-49) imageName:@"bg.png"];
    [self.view addSubview:imageView];
    imageView.userInteractionEnabled = YES;
//
//    UIImageView * image = [MyControl createImageViewFrame:CGRectMake(12, imageView.frame.size.height-64-8-190, MRScreenWidth-12*2, 190) imageName:@"konianbai@1x.png"];
//    [imageView addSubview:image];
//    
//    // 353*189
//    UIImageView * animg = [MyControl createImageViewFrame:CGRectMake(30, (image.frame.size.height-70)/2, 55, 58) imageName:@"daanquanbiao@1x.png"];
//    //animg.backgroundColor = [UIColor greenColor];
//    [image addSubview:animg];
//    
//   // UILabel * txtLab1 = [MyControl createLabelFrame:CGRectMake(100, (image.frame.size.height-70)/2, 150, 30) font:21 Text:@"账户资金安全由"];
//    UILabel * txtLab1 = [MyControl createLabelFrame:CGRectMake(100, (image.frame.size.height-70)/2, 150, 30) font:21 Text:@"账户资金安全由"];
//    //txtLab1.backgroundColor = [UIColor redColor];
//    [image addSubview:txtLab1];
//    
//    UILabel * txtLab2 = [MyControl createLabelFrame:CGRectMake(100, (image.frame.size.height-70)/2+30,150, 28) font:17 Text:@"华安财险100%承保"];
//   // txtLab2.backgroundColor = [UIColor redColor];
//    
//    [image addSubview:txtLab2];
    
    
    UIButton * start = [MyControl createButtonFrame:CGRectMake(12,imageView .frame.size.height-64, MRScreenWidth-12*2,55) Title:@"开始赚钱" BgImageName:nil ImageName:nil Method:@selector(startClick) target:self];
    [start setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    start.layer.cornerRadius = 5;
    start.clipsToBounds = YES;
    start.backgroundColor = [MyControl getColor:@"509ef0"];
    [imageView addSubview:start];
    
//    UIView * viq = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, MRScreenHeight-29-64)];
//    viq.backgroundColor = [UIColor blackColor];
//    //[self.aTableView addSubview:viq];
//    UIButton * start = [MyControl createButtonFrame:CGRectMake(0, viq.frame.size.height-80, MRScreenWidth-20,40) Title:@"开始赚钱" BgImageName:nil ImageName:nil Method:@selector(startClick) target:self];
//       start.backgroundColor = [UIColor redColor];
//       [viq addSubview:start];
    
    
//    if (1) {
//        [self getConnect];
//    } {
//        //   tiaozhuandenglu
//    }
#pragma mark 未登录进入我的资产页面是否显示马上赚钱
 
    if (!gAppDelegate.userModel.userName) {
        
        imageView.hidden = NO;
    }else{
    
        imageView.hidden = YES;
        NSLog(@"11111111111%@",[[NSUserDefaults standardUserDefaults]objectForKey:kLoginUserName]);
    }
//    imageView.hidden = NO;
}
- (void)tbtnClick
{
    NSLog(@"footView");

}

- (void)seeClick
{

    NSLog(@"查看交易");
    
    
    RecordController * record = [[RecordController alloc]init];
    [self.navigationController pushViewController:record animated:YES];
}

- (void)startClick
{
    NSLog(@"赚钱");
    
//    if (![UserManage isDidLogin]) {
//        loginViewController * login = [[loginViewController alloc]init];
//        // self.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:login animated:YES];
//    }else{
//        
//    
//        imageView.hidden = YES;
//    }
    
    
    LoginViewController * login = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
   
}
- (void)uploadData
{
    if (gAppDelegate.userModel.userId != nil) {
        NSString* url = @"u/userBitfinancingList";
        NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
        [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:kLoginTokenIdentifier] forKey:@"TOKEN"];
        [params setObject:gAppDelegate.userModel.userId forKey:@"userId"];
        [Httptool postWithURL:url Params:params Success:^(id json, HttpCode code) {
            NSDictionary* dic = (NSDictionary*)json;
            NSLog(@"%@",dic);
            if ([[dic objectForKey:@"code"] integerValue] == kHttpStatusOK) {
                mLab.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"capital"]];
                pLab.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"profit"]];
                
                NSArray* arr = [[dic objectForKey:@"data"] objectForKey:@"finList"];
                for (NSDictionary* mydic in arr) {
                    MyProductsListModel* myprolistmodel = [MyProductsListModel objectWithKeyValues:mydic];
                    [self.myarr removeAllObjects];
                    [self.myarr addObject:myprolistmodel];
                }
                [self.aTableView reloadData];
             }
            
            [self.aTableView tableViewDidFinishedLoading];
        } Failure:^(NSError *error) {
            
        }];

    }else{
        imageView.hidden = NO;
    }
     //    NSLog(@"cdnso");
//    [FTApi requestWithMethod:@"Get" withPath:API_MyZC withParams:nil complate:^(id response, NSError *error) {
//        if (error) {
//            NSLog(@"error==%@",error);
//        
//        }else{
//        
//            NSLog(@"respon--%@",response);
//            NSArray * arr = [response objectForKey:@"info"];
//            [dataArr removeAllObjects];
//
//        [dataArr addObjectsFromArray:[myMoneyModel modelArrayWithJsonArray:arr]];
//            NSLog(@"cdss%@",dataArr);
//          [self.aTableView reloadData];
//            mLab.text = [response objectForKey:@"totalMoney"];
//            pLab.text = [response objectForKey:@"totalProfit"];
//            [self.aTableView tableViewDidFinishedLoading];
//        }
//    }];
    
    
}
#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableVie
{
    refreshing = YES;
    [self performSelector:@selector(uploadData) withObject:nil afterDelay:0.f];
}

- (NSDate *)pullingTableViewRefreshingFinishedDate{
    return [NSDate date];
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    refreshing = NO;
    [self performSelector:@selector(uploadData) withObject:nil afterDelay:0.f];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == self.aTableView) {
        [self.aTableView tableViewDidEndDragging:scrollView];
    }
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.aTableView) {
        [self.aTableView tableViewDidScroll:scrollView];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myarr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        cell = [[MyMoneyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//显示箭头
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;//显示箭头
    MyProductsListModel * model = self.myarr[indexPath.row];
    
    NSArray * titArr = @[model.finname,model.bitAmount,model.updays,model.bitprofit];
    for (int i = 0; i<4; i++) {
        
        UILabel * lab = (UILabel *)[cell.contentView viewWithTag:205+i];
        
        lab.text = [NSString stringWithFormat:@"%@",titArr[i]];
    }
      //cell.cLab.text = model.productName;
    NSLog(@"%@",cell.cLab.text);
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    productInfoController * info = [[productInfoController alloc]init];
    RecordInfoView * info = [[RecordInfoView alloc]init];
    info.recordmodel = self.myarr[indexPath.row];
    [self.navigationController pushViewController:info animated:YES];

}


@end
