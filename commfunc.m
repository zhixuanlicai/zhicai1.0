//
//  commfunc.m
//  zhicai
//
//  Created by 陈思思 on 15/7/24.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "commfunc.h"

@implementation commfunc
+ (void)showCustInfo:(NSString*)title MessageString:(NSString*)message
{
    
    //empty
    if (message == nil || message.length == 0) {
        return;
    }
    
    //found html tag and other unexpected message
    if ([message.lowercaseString rangeOfString:@"<html"].location != NSNotFound ||
        [message.lowercaseString rangeOfString:@"an error has occurred"].location != NSNotFound)
    {
        message = @"服务器错误发生，我们正在解决中";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
    [alert show];
}

+ (NSDate*)stringToDate:(NSString*) str{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    return [inputFormatter dateFromString:str];
}

+ (NSString*) dateToString:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}

@end
