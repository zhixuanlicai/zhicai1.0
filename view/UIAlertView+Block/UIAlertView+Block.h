//
//  UIAlertView+Block.h
//  jimubox
//
//  Created by 程鹏辉 on 3/27/14.
//  Copyright (c) 2014 Jimubox. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CompleteBlock) (NSInteger buttonIndex);

@interface UIAlertView (Block)

// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showAlertViewWithCompleteBlock:(CompleteBlock) block;

@end
