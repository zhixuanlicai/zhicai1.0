//
//  LoadingViewController.m
//  zhicai
//
//  Created by 陈思思 on 15/7/30.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "AnimatedGif.h"
#import "MainTabBarController.h"
#import "LoginViewController.h"
#import "Register1ViewController.h"
#import "LoadingViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface LoadingViewController ()
{
    MPMoviePlayerController *_mpc1;
    MPMoviePlayerController *_mpc2;
    MPMoviePlayerController *_mpc3;
    NSArray *mp4Arr;
    UIScrollView *bgScrollView;
    UIButton *loginBtn;
    NSTimer *_timer;
}
@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];

    [self showLandingView];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
 
}

- (void)showLandingView
{

    
    if (!self.landingView)
    {
        self.landingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MRScreenWidth, MRScreenHeight)];
        [self.landingView setUserInteractionEnabled:YES];
        int landingCount = 3;
        
        bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MRScreenWidth, MRScreenHeight)];
        bgScrollView.backgroundColor = [UIColor blueColor];
        bgScrollView.contentSize = CGSizeMake(landingCount * MRScreenWidth, 0);
        bgScrollView.delegate = self;
        bgScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2页后.fw"]];
    
        bgScrollView.pagingEnabled = YES;
        bgScrollView.userInteractionEnabled = YES;
        bgScrollView.scrollsToTop= NO;

        bgScrollView.bounces = NO;
        
        mp4Arr = @[@"首次启动页1",@"首次启动页2",@"首次到金黄色",];
            NSString* path = [[NSBundle mainBundle] pathForResource:mp4Arr[0] ofType:@".m4v"];
            NSURL* url = [NSURL fileURLWithPath:path];
        
      
            _mpc1 = [[MPMoviePlayerController alloc] initWithContentURL:url];
            _mpc1.view.frame = CGRectMake(0, 0, MRScreenWidth, MRScreenHeight);
            //去掉进度条
            [_mpc1 setControlStyle:MPMovieControlStyleNone];
            [bgScrollView addSubview:_mpc1.view];
        
            [self.landingView addSubview:bgScrollView];
            
          NSLog(@"%f",bgScrollView.contentOffset.x);
        
        loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn setBackgroundImage:[UIImage imageNamed:@"landBtn.png"] forState:UIControlStateNormal];
        [loginBtn setBackgroundColor:[UIColor whiteColor]];
        loginBtn.exclusiveTouch = YES;
        [loginBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        loginBtn.frame = CGRectMake(MRScreenWidth*2+MRScreenWidth/2-80,MRScreenHeight- 260*(MRScreenHeight/568),160,44);
        
        //loginBtn.alpha = 0.5;
        
        [loginBtn addTarget:self action:@selector(landingLoginBtnPress) forControlEvents:UIControlEventTouchUpInside];
        self.landingView.alpha = 0;
        
        [UIView animateWithDuration:4.5f animations:^{
            CGRect frame = CGRectMake(-15,0,0,0);
            frame.size = [UIImage imageNamed:@"landing1.gif"].size;
            NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"landing1" ofType:@"gif"]];
            // view生成
            self.webView = [[UIWebView alloc] initWithFrame:frame];
            self.webView.userInteractionEnabled = NO;//用户不可交互
            [self.webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
            [self.view addSubview:self.webView];

            self.landingView.alpha = 1;
        } completion:^(BOOL finished) {
            [self.view addSubview:self.landingView];
            //开始播放启动视频
            [_mpc1 play];

        }];
        
    }

}

// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"______%f",bgScrollView.contentOffset.x);
    
    if(bgScrollView.contentOffset.x>1.0){

        NSString* path = [[NSBundle mainBundle] pathForResource:mp4Arr[1] ofType:@".m4v"];
        NSURL* url = [NSURL fileURLWithPath:path];
        _mpc2 = [[MPMoviePlayerController alloc] initWithContentURL:url];
        _mpc2.view.frame = CGRectMake(MRScreenWidth, 0, MRScreenWidth, MRScreenHeight);
        //去掉进度条
        [_mpc2 setControlStyle:MPMovieControlStyleNone];
        [bgScrollView setContentOffset:CGPointMake(MRScreenWidth, 0) animated:YES];

        [bgScrollView addSubview:_mpc2.view];
        [_mpc2 play];
        
    }
    
    NSLog(@"++++%f",bgScrollView.contentOffset.x);
    
    if(bgScrollView.contentOffset.x>MRScreenWidth){
        NSString* path = [[NSBundle mainBundle] pathForResource:mp4Arr[2] ofType:@".m4v"];
        NSURL* url = [NSURL fileURLWithPath:path];
        _mpc3 = [[MPMoviePlayerController alloc] initWithContentURL:url];
        _mpc3.view.frame = CGRectMake(MRScreenWidth*2, 0, MRScreenWidth, MRScreenHeight);
        
        //去掉进度条
        [_mpc3 setControlStyle:MPMovieControlStyleNone];
        [bgScrollView setContentOffset:CGPointMake(MRScreenWidth *2, 0) animated:YES];
        [bgScrollView addSubview:_mpc3.view];
         [bgScrollView addSubview:loginBtn];
        loginBtn.enabled = NO;
        [_mpc3 play];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(findBtn) userInfo:nil repeats:NO];
    }
    
}

-(void)findBtn
{
  //  [bgScrollView addSubview:loginBtn];
    loginBtn.enabled = YES;
    [_timer invalidate];

}

-(void)landingLoginBtnPress{
    
    MainTabBarController * tab = [[MainTabBarController alloc]init];
    [self presentViewController:tab animated:YES completion:nil];
}
@end
