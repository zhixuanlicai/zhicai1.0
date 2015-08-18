//
//  LoadingViewController.h
//  zhicai
//
//  Created by 陈思思 on 15/7/30.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingViewController : UIViewController<UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView* loadingImage;
@property(nonatomic,strong)UIImageView* loadingImage1;
@property(nonatomic,strong)UIImageView* loadingImage2;



@property(nonatomic,strong)UIView *landingView;
@property(nonatomic,strong)UIWebView* webView;

@end
