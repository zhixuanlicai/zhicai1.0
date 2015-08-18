
//
//  DetaiController.m
//  zhicai
//
//  Created by perfect on 15/4/2.
//  Copyright (c) 2015年 perfect. All rights reserved.
#import "LoginViewController.h"
#import "ProgramIntrduceController.h"
#import "MainTabBarController.h"
#import "SaleViewController.h"
#import "productViewController.h"
#import "DetaiController.h"
#import "PullingRefreshTableView.h"
#import "BuyController.h"
#import "FTApi.h"
#import "IsMortgageController.h"
@interface DetaiController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    NSMutableArray *_imageArr;
}

@property(nonatomic,retain)PullingRefreshTableView * aTableView;
@property(nonatomic,retain)NSArray*dataArray;

@end

@implementation DetaiController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    _imageArr = [[NSMutableArray alloc] init];
    [self createNav];
    [self createView];
    [self createTableView];
    [self loadData];
}

- (void)loadData
{

    self.dataArray = @[@"项目介绍",@"关于供应商",@"资产安全体系",@"是否有抵押",@"投资建议"];
}
- (void)createNav
{
    
     self.navigationController.navigationBarHidden = YES;

    UIView* myview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MRScreenWidth, kStatusBarHeight)];
    myview.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:myview];
    
    self.navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@""];

    if (self.isSalevc) {
        self.navlab.text = self.homemodel.finname;
    }else{
        self.navlab.text = self.promodel.proName;
    }
    self.navlab.textAlignment = YES;
    self.navlab.textColor = [MyControl getColor:@"ffffff"];
    self.navlab.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
   [myview addSubview:self.navlab];
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 63, MRScreenWidth-30, 1)];
    lineView.backgroundColor = [MyControl getColor:@"#509ef0"];
   [self.view addSubview:lineView];
   UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 26, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    backBtn.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [myview addSubview:backBtn];
}


- (void)createView
{
    

    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, 204-64)];
    headView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:headView];
    
    UILabel * yuLab = [MyControl createLabelFrame:CGRectMake(10, 64-64, 100, 32) font:14 Text:@"预期年化收益"];
      yuLab.textColor = [MyControl getColor:@"ffffff"];
    //yuLab.backgroundColor = [UIColor redColor];
    [headView addSubview:yuLab];
    
    self.tLab = [MyControl createLabelFrame:CGRectMake(16, 105-64, 66, 16) font:11 Text:nil];//@"期限35天"
    //tLab = [[UILabel alloc]initWithFrame:CGRectMake(16, 105-64, 66, 16)];
    self.tLab.layer.cornerRadius =4;
    self.tLab.clipsToBounds = YES;
    self.tLab.textColor = [UIColor colorWithRGBHex:0x509ef0];
    self.tLab.textAlignment = NSTextAlignmentCenter;
    self.tLab.backgroundColor = [MyControl getColor:@"#ffffff"];
    if (self.isSalevc) {
        self.tLab.text = [NSString stringWithFormat:@"期限%@天",self.homemodel.bitLimit];
    }else{
        self.tLab.text = [NSString stringWithFormat:@"期限%d天",self.promodel.lastDateLong.intValue/ (1000 * 60 * 60 * 24)];

    }
    [headView addSubview:self.tLab];
    
     self.personLab = [MyControl createLabelFrame:CGRectMake(16, 125-64, 120, 40) font:18 Text:nil];//@"1600000人"
    self.personLab.textColor = [MyControl getColor:@"#ffffff"];
    if (self.isSalevc) {
        self.personLab.text = [NSString stringWithFormat:@"%@人",self.homemodel.upedbuyer];
    }else{
        self.personLab.text = [NSString stringWithFormat:@"%@人",self.promodel.upedbuyer];
    }
    [headView addSubview:self.personLab];
    
    UILabel * buyLab = [MyControl createLabelFrame:CGRectMake(16, 160-64, 80, 15) font:11 Text:@"已购买"];
    buyLab.textColor = [MyControl getColor:@"#ffffff"];
    [headView addSubview:buyLab];
    
     self.glab =[MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-200, 64-64, 200, 105) font:70 Text:nil];//@"10.00"
    self.glab.textColor= [MyControl getColor:@"#ffffff"];
    if (self.isSalevc) {
        self.glab.text = [NSString stringWithFormat:@"%.2f",self.homemodel.finrate.floatValue];
    }else{
        self.glab.text = [NSString stringWithFormat:@"%.2f",self.promodel.finRate.floatValue];
    }

   // glab.backgroundColor = [UIColor redColor];
    [headView addSubview:self.glab];
    
    UILabel * fuLab =[MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-30, 50, 30, 30) font:23 Text:@"%"];
    fuLab.textColor= [MyControl getColor:@"#ffffff"];
    //fuLab.backgroundColor = [UIColor purpleColor];
    [headView addSubview:fuLab];

    UIView* footview = [[UIView alloc] initWithFrame:CGRectMake(0, 204-84, MRScreenWidth, 20)];
    footview.backgroundColor  = [UIColor colorWithRGBHex:0xededed];
    [headView addSubview:footview];
//    UIView * linView = [[UIView alloc]initWithFrame:CGRectMake(15, 183-64, MRScreenWidth-15*2, 1)];
//    linView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
//    [headView addSubview:linView];
//    
//    UIView * linView1 = [[UIView alloc]initWithFrame:CGRectMake(15, 204-63, MRScreenWidth-15*2, 1)];
//    linView1.backgroundColor = [MyControl getColor:@"#D4D4D4"];
//    [headView addSubview:linView1];
    
    
}


- (void)createTableView
{
        self.aTableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, MRScreenHeight-64-50-22)];
        self.aTableView.backgroundColor = [UIColor colorWithRGBHex:0xededed];

        self.aTableView.dataSource = self;
        self.aTableView.delegate = self;
        self.aTableView.pullingDelegate = self;
        self.aTableView.tableHeaderView = headView;
        //self.aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.aTableView.separatorColor = [UIColor clearColor];//改变tableView的背景色，也就是去除去除下面的横线，添加自己设置的lineView
        [self.view addSubview:self.aTableView];
        [self.aTableView launchRefreshing];
    
     self.aTableView.tableFooterView = nil;
    //230
    
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 50)];
        
        footView.backgroundColor = [UIColor colorWithRGBHex:0xededed];
        self.aTableView.tableFooterView  = footView;
        UIButton * totoalBtn =[MyControl createButtonFrame:CGRectMake((MRScreenWidth-217)/2, 5, 217, 40) Title:nil BgImageName:nil ImageName:nil Method:@selector(tbtnClick) target:self];
        //totoalBtn.backgroundColor = [UIColor redColor];
        [footView addSubview:totoalBtn];
        
        UIImageView * aimg = [MyControl createImageViewFrame:CGRectMake(0, 5, 28, 29) imageName:@"anquan.png"];
        [totoalBtn addSubview:aimg];
        
        UILabel * txtLab = [MyControl createLabelFrame:CGRectMake(30, 0, 200, 40) font:12 Text:@"账户资金安全由华安财险100%承保"];
        txtLab.textColor = [MyControl getColor:@"26526C"];
        [totoalBtn addSubview:txtLab];
        
        UIButton * moneyBtn = [MyControl createButtonFrame:CGRectMake(16,MRScreenHeight-50-11, MRScreenWidth-16*2,50) Title:nil BgImageName:nil ImageName:nil Method:@selector(startClick) target:self];
        [moneyBtn setTitleColor:[UIColor colorWithRGBHex:0x509ef0] forState:UIControlStateNormal];
        moneyBtn.layer.cornerRadius = 5;
        moneyBtn.clipsToBounds = YES;
        moneyBtn.layer.borderWidth = 2;
        moneyBtn.layer.borderColor = [UIColor colorWithRGBHex:0x509ef0].CGColor;
        moneyBtn.backgroundColor = [MyControl getColor:@"ffffff"];
        [self.view  addSubview:moneyBtn];
        UILabel * moneyLab = [MyControl createLabelFrame:CGRectMake((moneyBtn.frame.size.width-80)/2, 0, 80, 30) font:15 Text:@"马上赚钱"];
        moneyLab.textAlignment = YES;
        moneyLab.textColor = [UIColor colorWithRGBHex:0x509ef0];
        [moneyBtn addSubview:moneyLab];
        
        self.canLab = [MyControl createLabelFrame:CGRectMake((moneyBtn.frame.size.width-130)/2, 27, 130, 20) font:12 Text:nil];//@"剩余3600000份可购买"
        self.canLab.textAlignment = YES;
        self.canLab.textColor = [MyControl getColor:@"#509ef0"];
    if (self.isSalevc) {
        self.canLab.text = [NSString stringWithFormat:@"剩余%@份可购买",self.homemodel.soldPre];
    }else{
        self.canLab.text = [NSString stringWithFormat:@"剩余%@份可购买",self.promodel.soldPre];
    }
        [moneyBtn addSubview:self.canLab];
    }


- (void)tbtnClick
{

    NSLog(@"dfvggh");


}
- (void)startClick
{

    if (gAppDelegate.userModel.mobilePhone == nil) {
        UIAlertView * alertV = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有登陆，请登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertV showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                LoginViewController* loginvc = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:loginvc animated:YES];
            }
        }];

    }else{
        if (self.isSalevc) {
            BuyController * buyView = [[BuyController alloc]init];
            buyView.homemodel = self.homemodel;
            buyView.isHomemodel = YES;
            
            [self.navigationController pushViewController:buyView animated:YES];

        }else{
            BuyController * buyView = [[BuyController alloc]init];
            buyView.promodel = self.promodel;
            buyView.isHomemodel = NO;
            [self.navigationController pushViewController:buyView animated:YES];
        }
    }
    NSLog(@"cfvdebb");

}

- (void)uploadData
{

    [self.aTableView tableViewDidFinishedLoading];

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
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//显示箭头
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;//显示箭头
    NSArray*array=@[@"leimu1.png",@"leimu2.png",@"leimu3.png",@"leimu4.png",@"leimu5.png"];
    cell.imageView.image=[UIImage imageNamed:array[indexPath.row]];
    cell.textLabel.text=self.dataArray[indexPath.row];
    
    //设置cell底部横线
    switch (indexPath.row) {
        case 0:
        {
            UIView * cellLineView = [[UIView alloc]initWithFrame:CGRectMake(15, 43, MRScreenWidth-15*2, 1)];
            cellLineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
            [cell.contentView addSubview:cellLineView];
            
            UIImageView * img1 = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, (40-11)/2+3, 7, 11) imageName:@"dxiayib@1x.png"];
            [cell.contentView addSubview:img1];
        }
            
            break;
        case 1:
        {
            UIView * cellLineView = [[UIView alloc]initWithFrame:CGRectMake(15, 43, MRScreenWidth-15*2, 1)];
            cellLineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
            [cell.contentView addSubview:cellLineView];
            UIImageView * img2 = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, (40-11)/2+3, 7, 11) imageName:@"dxiayib@1x.png"];
            [cell.contentView addSubview:img2];
        }
            break;
        case 2:
        {
            UIView * cellLineView = [[UIView alloc]initWithFrame:CGRectMake(15, 43, MRScreenWidth-15*2, 1)];
            cellLineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
            [cell.contentView addSubview:cellLineView];
            UIImageView * img3 = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, (40-11)/2+3, 7, 11) imageName:@"dxiayib@1x.png"];
            [cell.contentView addSubview:img3];
        }
            break;
        case 3:
        {
            UIView * cellLineView = [[UIView alloc]initWithFrame:CGRectMake(15, 43, MRScreenWidth-15*2, 1)];
            cellLineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
            [cell.contentView addSubview:cellLineView];
            
             yLab = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-30, 0, 30, 40) font:15 Text:nil];
            yLab.textAlignment = YES;
            yLab.text = @"是";
            [cell.contentView addSubview:yLab];
            
            if (self.promodel.financingPicList.count) {
                yLab.textColor = [MyControl getColor:@"0x509ef0"];
                cell.userInteractionEnabled = YES;
            }else{
                yLab.textColor = [MyControl getColor:@"#8E8E8E"];
                cell.userInteractionEnabled = NO;
            }
            
        }
            break;
        case 4:
        {
            UIView * cellLineView = [[UIView alloc]initWithFrame:CGRectMake(15, 59, MRScreenWidth-15*2, 1)];
            cellLineView.backgroundColor = [MyControl getColor:@"#ededed"];
            [cell.contentView addSubview:cellLineView];
            
            UILabel * lab1 = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-29-16-5-80, 8,80, 30) font:13 Text:@"风险等级评定"];
            lab1.textColor = [MyControl getColor:@"#31424A"];
            //lab1.backgroundColor = [UIColor redColor];
            lab1.textAlignment = YES;
            [cell.contentView addSubview:lab1];
            
            lab2 = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-29-16, 8,29, 30) font:15 Text:nil];
            lab2.textColor = [UIColor whiteColor];
            //lab2.backgroundColor = [UIColor redColor];
            lab2.textAlignment = YES;
            lab2.layer.cornerRadius = 29/2;
            lab2.clipsToBounds = YES;
            lab2.text = @"高";
            lab2.backgroundColor = [MyControl getColor:@"#5fafe4"];
            [cell.contentView addSubview:lab2];
            
            UILabel * lab3 = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-110, 40, 100, 20) font:10 Text:@"适合做资产配置安全垫"];
            lab3.textColor = [MyControl getColor:@"#8E8E8E"];
           // lab3.backgroundColor = [UIColor redColor];
            lab3.textAlignment = YES;
            [cell.contentView addSubview:lab3];
            //cell.contentView.backgroundColor = [UIColor colorWithRGBHex:0xededed];
            cell.userInteractionEnabled = NO;
        }
            break;
        default:
            break;
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 4) {
        return 60;
    }else
    {
        return 44;
    
    }
    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            ProgramIntrduceController* prointroducevc = [[ProgramIntrduceController alloc] init];
            [self.navigationController pushViewController:prointroducevc animated:YES];
            }
            break;
        case 3:{
            IsMortgageController *isMortage = [[IsMortgageController alloc] init];
            
            for (NSDictionary *dic in self.promodel.financingPicList) {
                [_imageArr addObject:dic[@"url"]];
            }
            //先赋值，然后清空，防止下次点击时叠加
            isMortage.imageArr = [NSMutableArray arrayWithArray:_imageArr];
            [_imageArr removeAllObjects];
            [self.navigationController pushViewController:isMortage animated:YES];
            
        }
            break;
        default:
            break;
    }
}
#pragma mark footerView


- (void)backClick
{

    [self.navigationController popViewControllerAnimated:YES];
    self.parentViewController.tabBarController.tabBar.hidden = NO;
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


@end
