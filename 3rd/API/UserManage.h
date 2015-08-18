//
//  UserManage.h
//  RuiSi
//
//  Created by  yanguang on 4/5/14.
//  Copyright (c) 2014 yyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTApi.h"

@interface UserManage : NSObject

+ (BOOL)successWithResponse:(NSDictionary*)dic;
+ (BOOL)isDidLogin;
+ (void)loginOut;
+ (NSString*)groupID;
+ (NSString*)userKey;
+ (NSString*)userPhone;


@end
