//
//  IsMortgageControllerViewController.m
//  zhicai
//
//  Created by MJP on 12/8/15.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "IsMortgageController.h"

@interface IsMortgageController ()
{
    UIScrollView *_scView;
    UIImageView *_image;
   // NSMutableArray *_imageArr;
    NSTimer *_timer;
    int j;
    NSInteger imageCount;
    
}
@end

@implementation IsMortgageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    j=0;
    [self createNav];
    [self createScrollView];
  
}

- (void)viewWillAppear:(BOOL)animated
{
    
    self.parentViewController.tabBarController.tabBar.hidden = YES;
}

- (void)createNav
{
    
    self.navigationController.navigationBarHidden = YES;
    
    UIView* myview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MRScreenWidth, kStatusBarHeight)];
    myview.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:myview];
    
    self.navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@""];
    
//    if (self.isSalevc) {
//        self.navlab.text = self.homemodel.finname;
//    }else{
//        self.navlab.text = self.promodel.proName;
//    }
    self.navlab.text = @"抵押";
    self.navlab.textAlignment = YES;
    self.navlab.textColor = [MyControl getColor:@"ffffff"];
    self.navlab.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [myview addSubview:self.navlab];
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 63, MRScreenWidth-30, 1)];
    lineView.backgroundColor = [MyControl getColor:@"#509ef0"];
    [self.view addSubview:lineView];
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 20, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    backBtn.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [myview addSubview:backBtn];
}

-(void)createScrollView
{
    
    NSInteger count = [self.imageArr count];
    imageCount = self.imageArr.count;
    
    _scView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, MRScreenWidth, MRScreenHeight-64)];
    _scView.pagingEnabled = YES;
  //  _scView.showsHorizontalScrollIndicator = NO;
    _scView.bounces = NO;
    _scView.contentSize = CGSizeMake(MRScreenWidth *count, MRScreenHeight-64);
    [self startSV];
    [self.view addSubview:_scView];
    NSLog(@"%@",self.imageArr);

    for (int i = 0; i< count; i++) {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(MRScreenWidth*i ,0, _scView.frame.size.width,_scView.frame.size.height)];
        NSURL *url = [NSURL URLWithString:self.imageArr[i]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        _image.image = [UIImage imageWithData:data];
        [_scView addSubview:_image];
    }
}

-(void)startSV
{
    _timer =[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
}

-(void)timerClick
{
    if (j<imageCount) {
        [_scView setContentOffset:CGPointMake(MRScreenWidth *j, 0) animated:YES];
        NSLog(@"-----------%d",j);
        j++;
    }else{
        [_timer invalidate];
    }
}

- (void)backClick
{
    //在返回前先kill定时器
    [_timer invalidate];
    //清空数组
    [self.imageArr removeAllObjects];

    [self.navigationController popViewControllerAnimated:YES];
    self.parentViewController.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
