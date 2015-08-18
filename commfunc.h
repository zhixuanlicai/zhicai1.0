//
//  commfunc.h
//  zhicai
//
//  Created by 陈思思 on 15/7/24.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commfunc : NSObject
+ (void)showCustInfo:(NSString*)title MessageString:(NSString*)message;
+ (NSDate*)stringToDate:(NSString*) str;
+ (NSString*) dateToString:(NSDate*)date;
@end
