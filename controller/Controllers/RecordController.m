//
//  recordController.m
//  zhicai
//
//  Created by perfect on 15/4/8.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "recordModel.h"
#import "RecordController.h"
#import "PullingRefreshTableView.h"
#import "RecordCell.h"
#import "RecordInfoView.h"
#import "FTApi.h"
#import "FTModel.h"

@interface RecordController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    BOOL refreshing;
    UIView * footView;
    NSMutableArray * dataArr;

}

@property(nonatomic,strong)PullingRefreshTableView * atableView;

@end
@implementation RecordController

-(void)connect{
    NSString* url = @"u/userBitfinancingList";
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    
    [params setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginToken"] forKey:@"TOKEN"];
    [params setObject:gAppDelegate.userModel.userId forKey:@"userId"];
    //[params setObject:@"" forKey:@""];
    [Httptool postWithURL:url Params:params Success:^(id json, HttpCode code) {
        NSDictionary* dic = (NSDictionary*)json;
        NSLog(@"%@",dic);
        ;
        if ([[dic objectForKey:@"code"] integerValue] == kHttpStatusOK) {
            NSArray* arr = [[dic objectForKey:@"data"] objectForKey:@"finList"];
            [self.recordarr removeAllObjects];
            for (NSDictionary* mydic in arr) {
                recordModel* recmodel = [recordModel objectWithKeyValues:mydic];
                
                [self.recordarr addObject:recmodel];
            }
            [self.atableView reloadData];
            [self.atableView tableViewDidFinishedLoading];
        }
        
        else{
            [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error) {
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.recordarr = [[NSMutableArray alloc]init];
    [self createNav];
    [self createTable];
//    dataArr = [[NSMutableArray alloc]initWithCapacity:0];
}
- (void)createNav
{
    self.view.backgroundColor = [MyControl getColor:@"EDEDED"];
    self.navigationController.navigationBarHidden = YES;
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"交易记录"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"010D12"];
    [navView addSubview:navlab];
    
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    //backBtn.backgroundColor = [UIColor redColor];
    
    [navView addSubview:backBtn];
    
//    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 63, MRScreenWidth-30, 1)];
//    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
//    [navView addSubview:lineView];
    
}

- (void)createTable
{

    self.atableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 64, MRScreenWidth, MRScreenHeight-64) style:UITableViewStylePlain];
   // self.atableView.backgroundColor = [UIColor redColor];
    self.atableView.dataSource = self;
    self.atableView.delegate = self;
    self.atableView.pullingDelegate = self;
    //self.aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.aTableView.rowHeight = 40;
    self.atableView.separatorColor = [UIColor clearColor];//改变tableView的背景色，也就是去除去除下面的横线，添加自己设置的lineView
    [self.view addSubview:self.atableView];
    [self.atableView launchRefreshing];
    
    
    self.atableView.tableFooterView = nil;
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 40)];
    self.atableView.tableFooterView  = footView;
    
    UILabel * recordLab = [MyControl createLabelFrame:CGRectMake(0, 0, MRScreenWidth, 40) font:10 Text:@"以上为全部交易记录"];
    recordLab.textColor = [MyControl getColor:@"8E8E8E"];
    recordLab.textAlignment = YES;
    [footView addSubview:recordLab];
}
- (void)uploadData
{
    [self connect];
//    [FTApi requestWithMethod:@"Get" withPath:API_ProductRecord withParams:nil complate:^(id response, NSError *error) {
//        if (error) {
//            NSLog(@"error==%@",error);
//        
//        }else{
//        
//            NSLog(@"responRecord%@",response);
//            
//        
//        }
//    }];
//   [self.atableView tableViewDidFinishedLoading];


}

#pragma mark tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return dataArr.count;
    return self.recordarr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"ID";
    
    RecordCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[RecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    recordModel* model = self.recordarr[indexPath.row];
    [cell setmodel:model];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 77;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordInfoView * info = [[RecordInfoView alloc]init];
    info.recordmodel = self.recordarr[indexPath.row];
    [self.navigationController pushViewController:info animated:YES];
//    switch (indexPath.row) {
//        case 0:
//        {
//        
//            recordInfoView * info = [[recordInfoView alloc]init];
//            [self.navigationController pushViewController:info animated:YES];
//            
//        }
//            break;
//        case 1:
//        {
//            recordInfoView * info = [[recordInfoView alloc]init];
//            [self.navigationController pushViewController:info animated:YES];
//        }
//            break;
//        default:
//            break;
//    }
//

}
#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    refreshing = YES;
    [self performSelector:@selector(uploadData) withObject:nil afterDelay:0.f];
}

- (NSDate *)pullingTableViewRefreshingFinishedDate{
    return [NSDate date];
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    refreshing = NO;
    [self performSelector:@selector(uploadData) withObject:nil afterDelay:5.f];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == self.atableView) {
        [self.atableView tableViewDidEndDragging:scrollView];
    }
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.atableView) {
        [self.atableView tableViewDidScroll:scrollView];
    }
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



@end
