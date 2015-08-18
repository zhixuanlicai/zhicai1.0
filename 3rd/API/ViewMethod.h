//
//  ViewMethod.h
//  WeddingSweet
//
//  Created by yyt on 14/12/16.
//  Copyright (c) 2014年 iwed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewMethod : NSObject
+ (UIColor*)colorWithHexString:(NSString *)hexStr;

+(NSString *)stringFromtoDate:(NSString *)str;
+(NSString *)stringFromDate:(NSDate *)date;

@end



@interface UIImage (Tint)

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

@end


