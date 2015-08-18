//
//  productViewController.m
//  zhicai
//
//  Created by perfect on 15/3/23.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "productViewController.h"
#import "PullingRefreshTableView.h"
#import "FTApi.h"
#import "MJRefresh.h"
#import "NoProductCell.h"
#import "DetaiController.h"
#import "UserManage.h"
#import "LoginViewController.h"
#import "FTModel.h"
#import "productModel.h"

@interface productViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    NSArray * SelArr;
    NSArray * unSelArr;
    BOOL refreshing;
    NSMutableArray * dataArray; // 总数据
    //NSUInteger num;//页数
    
   NSArray * Iarr;
   NSArray * Rarr;
   // productModel * model;
    //图片url
    NSString *imageUrl;
    
}

@property(nonatomic,retain)UIScrollView * scrollView;//三个UItableView滑动视图
@property (nonatomic, strong)UIView *lineView; // 滑动改变的线条
@property (nonatomic, strong)UIButton *selectButton; // 当前选中的UIButton
@property (nonatomic,strong)UISegmentedControl * segment;
@property (nonatomic)NSInteger num;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * actarr;
@property (nonatomic,strong) NSMutableArray * longarr;

@end

@implementation productViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
 //   num = 0;
    //关闭导航自适配，避免下面的sctollView的上下滑动
    
    imageUrl = [[NSString alloc] init];
    dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    self.actarr = [[NSMutableArray alloc]init];
    self.longarr = [[NSMutableArray alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    refreshing = YES;
    [self createNav];
    [self createButton];
    [self createScrollView];
    [self createTableView];
    [self request];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.actarr removeAllObjects];
    [self.longarr removeAllObjects];
}

- (void)createNav
{
   self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = YES;
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:navView];

    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"理财产品"];
    //navlab.backgroundColor = [UIColor redColor];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    navlab.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [navView addSubview:navlab];
    
}

- (void)request
{
 
    if (self.segment.selectedSegmentIndex == 0) {
        //NSString* url = [NSString stringWithFormat:@"u/actBowBillList?startPage=0&TOKEN＝%@",gAppDelegate.userModel.tokenId];
        NSString* url = @"o/actBowBillList?startPage=0";
        [Httptool getWithURL:url Params:nil Success:^(id json, HttpCode code) {
            NSDictionary* dic = (NSDictionary*)json;
            NSLog(@"%@",dic);
            if (code == [[dic objectForKey:@"code"] integerValue]) {
                NSArray* arr = [dic objectForKey:@"data"];
                for (NSDictionary* modeldic in arr) {
                    productModel* promodel = [productModel objectWithKeyValues:modeldic];
                    [self.actarr addObject:promodel];
                }
                
            }else{
                [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
            }
        } Failure:^(NSError *error) {
            
        }];
    }else{
       // NSString* url = [NSString stringWithFormat:@"u/longBowBillList?startPage=0&TOKEN＝%@",gAppDelegate.userModel.tokenId];
        NSString* url = @"o/longBowBillList?startPage=0";
        [Httptool getWithURL:url Params:nil Success:^(id json, HttpCode code) {
            NSDictionary* dic = (NSDictionary*)json;
            NSLog(@"%@",dic);
            if (code == [[dic objectForKey:@"code"] integerValue]) {
                    NSArray* arr1 = [dic objectForKey:@"data"];
                    for (NSDictionary* modeldic in arr1) {
                        productModel* promodel = [productModel objectWithKeyValues:modeldic];
                        [self.longarr addObject:promodel];
                       // NSLog(@"88888888%@",promodel.financingPicList);
                    }
                
                
            }else{
                [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
            }

        } Failure:^(NSError *error) {
            
        }];
        

    }
//    str  = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [FTApi requestWithMethod:@"Get" withPath:str withParams:nil  complate:^(id responseObject,NSError*error){
//        
//        if (error) {
//            NSLog(@"============error==%@",error);
//            
//        }else{
//            NSLog(@"-----respon45000%@",responseObject );
//            
//            
//           Iarr =[responseObject objectForKey:@"Irregular"];
//            NSLog(@"0000000%@",Iarr);
//            
//            NSLog(@"irrarr%@",Iarr);
//
//            Rarr = [responseObject objectForKey:@"Regularly"];
//            NSLog(@"rarr%@",Rarr);
//            
//            [dataArray addObjectsFromArray:[productModel modelArrayWithJsonArray:Iarr]];
//           [dataArray addObjectsFromArray:[productModel modelArrayWithJsonArray:Rarr]];
//            
//        }
//    }];
}


#pragma mark - 滑动三个按钮栏 Tag = 100 + i;
- (void)createButton
{
    NSArray *array = [NSArray arrayWithObjects:@"不定期发售", @"长期发售", nil];
    
    self.segment = [[UISegmentedControl alloc]initWithItems:array];
    _segment.frame = CGRectMake(15, 74, MRScreenWidth-15*2, 25);
    _segment.selectedSegmentIndex = 0;
    [_segment addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
   // _segment.segmentedControlStyle = UISegmentedControlStylePlain;//设置样式
    _segment.tintColor = [MyControl getColor:@"#509ef0"];
    [self.view addSubview:_segment];
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 109, MRScreenWidth, 1)];
    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [self.view addSubview:lineView];
    
//     SelArr = @[@"zuohuatiaoClick@2x.png",@"youhuatiaoClick@2x.png"];
//    unSelArr = @[@"zuohuatiao@2x.png",@"youhuatiao@2x.png"];
//
//    for (int i = 0; i < 2; i++)
//    {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.tag = 100 + i;
//        button.frame = CGRectMake((MRScreenWidth-290)/2+145*i, 60, 140, 25);
//        //button.backgroundColor = [UIColor redColor];
//     //   button.frame = CGRectMake((MRScreenWidth-)/2+350*i, 60, 350, 40);
//        //button.backgroundColor = [UIColor redColor];
//        [button addTarget:self action:@selector(threeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
//        [button setTitleColor:[MyControl getColor:@"010D12"] forState:UIControlStateNormal];
//         [button setBackgroundImage:[UIImage imageNamed:unSelArr[i]] forState:UIControlStateNormal];
    
       // button.titleLabel.font = [UIFont systemFontOfSize:14];
//        [button setImage:[UIImage imageNamed:unSelArr[i]] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:SelArr[i]] forState:UIControlStateSelected];
//        [button setBackgroundImage:[UIImage imageNamed:SelArr[i]] forState:UIControlStateSelected];
       // [self.view addSubview:button];
        
    //}
    
//    UILabel * lab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 109, 100, 50) font:12 Text:@"nfv"];
//    lab.backgroundColor = [UIColor greenColor];
    //[self.view addSubview:lab];
    
    // 定义选中按钮
//    UIButton *button = (UIButton *)[self.view viewWithTag:100 + 0];
//    //[button setTitleColor:RGBA(41, 179, 242, 1.0) forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    button.backgroundColor = [MyControl getColor:@"#5fafe4"];
//    
//    self.selectButton = button;
}


- (void)segClick:(UISegmentedControl *)seg
{
    
    NSInteger Index = seg.selectedSegmentIndex;
    //NSLog(@"Index %ld", Index);
    switch (Index) {
        case 0:
        {
        [UIView animateWithDuration:0.2 animations:^{
            self.scrollView.contentOffset = CGPointMake(Index * MRScreenWidth, 0);
        } completion:^(BOOL finished) {
            UITableView* tableView = (UITableView *)[self.scrollView viewWithTag:200 + self.scrollView.contentOffset.x / MRScreenWidth];
            [self request];
            [tableView reloadData];
            [tableView headerBeginRefreshing];
          }];
        
        }
            break;
        case 1:
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.scrollView.contentOffset = CGPointMake(Index * MRScreenWidth, 0);
            } completion:^(BOOL finished) {
                UITableView* tableView = (UITableView *)[self.scrollView viewWithTag:200 + self.scrollView.contentOffset.x / MRScreenWidth];
                [self request];
                [tableView reloadData];
                [tableView headerBeginRefreshing];
              }];
            
        }
            break;
        default:
            break;
    }

}
//// 三个UISegment按钮的点击事件
//- (void)threeButtonAction:(UIButton *)sender {
//    // 如果当前选中button不是点击的button - 则进行改变
//    if (self.selectButton != sender)
//    {
//        [UIView animateWithDuration:0.2 animations:^{
//            self.scrollView.contentOffset = CGPointMake((sender.tag - 100) * MRScreenWidth, 0);
//        } completion:^(BOOL finished) {
////            [self.selectButton setTitleColor:RGBA(75, 75, 75, 1.0) forState:UIControlStateNormal];
////            [sender setTitleColor:RGBA(41, 179, 242, 1.0) forState:UIControlStateNormal];
//            [self.selectButton setTitleColor:[MyControl getColor:@"010D12"] forState:UIControlStateNormal];
//          
//            sender.backgroundColor = [MyControl getColor:@"#5fafe4"];
//            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            self.selectButton = sender;
//            
//        }];
//     
//        // 数组为空  ---  则刷新
//        UITableView *tableView = (UITableView *)[self.scrollView viewWithTag:200 + self.scrollView.contentOffset.x / MRScreenWidth];
//        [tableView headerBeginRefreshing];
//        
////        if ([[self.bigArray objectAtIndex:sender.tag - 100] count] == 0) {
////            [tableView headerBeginRefreshing];
////        }
//        
//    }
//    
//}

#pragma mark - 创建UITableView视图 Tag = 200 + i;
- (void)createScrollView
{
    // 设置UIScrollView属性
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 110, MRScreenWidth, MRScreenHeight-29-110)];
    //_scrollView.backgroundColor = RGBA(238, 238, 238, 1.0);
    //_scrollView.backgroundColor = [UIColor greenColor];
    _scrollView.delegate = self;
    _scrollView.bounces = NO; // 边框是否允许回弹
    _scrollView.userInteractionEnabled = YES; // 允许用户交互
    _scrollView.showsHorizontalScrollIndicator = NO; // 是否显示水平方向的滚动条
    _scrollView.directionalLockEnabled = YES; // 指定控件是否只能在一个方向上滚动
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(MRScreenWidth * 2, 0);
    [self.view addSubview:_scrollView];
    
    // 进来第一次刷新第一个UITableView -- 这里指创建
    

}

- (void)createTableView
{

    for (int i = 0; i < 2; i++)
    {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(MRScreenWidth * i, 5, MRScreenWidth, self.scrollView.frame.size.height-5) style:UITableViewStylePlain];
       // tableView.backgroundColor = [UIColor purpleColor];
        tableView.tag = 200 + i;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellEditingStyleNone;
        [self.scrollView addSubview:tableView];
        

            [tableView addFooterWithTarget:self action:@selector(footerRereshing)];
            [tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
            if (i == 0) {
                [tableView headerBeginRefreshing];
            }
        
    }
    
    
}

- (void)headerRereshing
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        UITableView* tableView = (UITableView *)[self.scrollView viewWithTag:200 + self.scrollView.contentOffset.x / MRScreenWidth];
        
        switch (tableView.tag-200) {
            case 0:
            {
                [tableView reloadData];
                [tableView headerEndRefreshing];
                
            }
                break;
            case 1:
            {
                [tableView reloadData];
                [tableView headerEndRefreshing];

            }
                break;
                
            default:
                break;
        }

    });
    

}
- (void)footerRereshing

{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UITableView* tableView = (UITableView *)[self.scrollView viewWithTag:200 + self.scrollView.contentOffset.x / MRScreenWidth];
        
        switch (tableView.tag-200) {
            case 0:
            {
                [tableView reloadData];
                [tableView footerEndRefreshing];
                
            }
                break;
            case 1:
            {
                [tableView reloadData];
                [tableView footerEndRefreshing];
                
            }
                break;

            default:
                break;
        }

    });
    
   
    
}


#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        float flag = self.scrollView.contentOffset.x/MRScreenWidth;
        self.segment.selectedSegmentIndex = flag;
        
        // 数组为空  ---  则刷新
       UITableView* tableView = (UITableView *)[self.scrollView viewWithTag:200 + self.scrollView.contentOffset.x / MRScreenWidth];
        [tableView reloadData];
        [tableView headerBeginRefreshing];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 //   return [dataArray count];
    if (tableView.tag == 200) {
        return self.actarr.count;
    }else{
        return self.longarr.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NoProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[NoProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
//    
    tableView = (UITableView *)[self.scrollView viewWithTag:200 + self.scrollView.contentOffset.x / MRScreenWidth];
    
    switch (tableView.tag-200) {
        case 0:
        {
            productModel * model = self.actarr[indexPath.row];
            [cell configModel:model];
            
        }
            break;
        case 1:
        {
            productModel * model = self.longarr[indexPath.row];
            [cell configModel:model];
            
        }
            break;
            
        default:
            break;
    }

    
    
//        productModel * model = dataArray[indexPath.row];
//        [cell configModel:model];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 97;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:kLoginUserName])
    {
        LoginViewController * login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        //        [self presentViewController:login animated:YES completion:^{
        //
        //        }];
        
    }else{
        if (tableView.tag == 200) {
            DetaiController * detail = [[DetaiController alloc]init];
            detail.isSalevc = NO;
            detail.promodel = self.actarr[indexPath.row];
            [self.navigationController pushViewController:detail animated:YES];
            [self.actarr removeAllObjects];
        }else{
            DetaiController * detail = [[DetaiController alloc]init];
            detail.promodel = self.longarr[indexPath.row];
            detail.isSalevc = NO;
            [self.navigationController pushViewController:detail animated:YES];
            [self.longarr removeAllObjects];

        }
        
    }

//    DetaiController * detail = [[DetaiController alloc]init];
//    [self.navigationController pushViewController:detail animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
