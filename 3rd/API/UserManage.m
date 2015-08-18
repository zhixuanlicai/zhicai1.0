//
//  UserManage.m
//  RuiSi
//
//  Created by  yanguang on 4/5/14.
//  Copyright (c) 2014 yyt. All rights reserved.
//

#import "UserManage.h"
@implementation UserManage

+ (void)loginOut
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:CURRENT_USER_KEY];
}
+ (BOOL)isDidLogin
{
    NSString *userKey = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENT_USER_PHONE];
    if (userKey.length>0) {
        return YES;
    }
    return NO;
}
+ (BOOL)successWithResponse:(NSDictionary*)dic
{
    BOOL isSuccess =  NO;
    if ([dic isKindOfClass:[NSDictionary class]]) {
        isSuccess = [[dic valueForKey:@"status"] boolValue];
    }
    return isSuccess;
}
+ (NSString*)groupID
{
    return @"1";
}
+ (NSDictionary*)userInfo
{
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults]valueForKey:CURRENT_USER_INFO];
    NSLog(@"%@",userInfo);
    return userInfo;
}
+ (NSString*)userPhone
{
    return [[NSUserDefaults standardUserDefaults]valueForKey:CURRENT_USER_PHONE];
}
+ (NSString*)userKey
{
    NSString *userKey = [[NSUserDefaults standardUserDefaults]valueForKey:CURRENT_USER_KEY];
    if (userKey == nil) {
        userKey = @"";
    }
    return userKey;
}

@end
