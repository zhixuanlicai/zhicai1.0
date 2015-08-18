//
//  MyControl.h
//  SnsDemo_1418
//
//  Created by zhangcheng on 14-8-15.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MyControl : NSObject
+(float)isIOS7;
#pragma mark 创建View
+(UIView *)createViewWithFrame:(CGRect)frame;
#pragma mark 创建ImageView
+(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString*)imageName;
#pragma mark 创建button
+(UIButton *)createButtonFrame:(CGRect)frame Title:(NSString*)title BgImageName:(NSString*)bgImageName ImageName:(NSString*)imageName Method:(SEL)sel target:(id)target;
#pragma mark 创建label
+(UILabel*)createLabelFrame:(CGRect)frame font:(float)font Text:(NSString*)text;
#pragma mark 创建textField
+(UITextField*)createTextFieldFrame:(CGRect)frame Placeholder:(NSString*)placeholder
                           leftView:(UIView*)leftView rightView:(UIView*)rightView BgImageName:(NSString*)bgImageName font:(float)font;
#pragma mark 颜色十六进制转换
+ (UIColor *) getColor: (NSString *)color;
@end
