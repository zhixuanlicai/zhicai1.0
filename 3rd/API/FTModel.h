//
//  FTModel.h
//  
//
//  Created by zgq on 13-3-19.
//  Copyright (c) 2013年 zgq. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PROPERTYNAME @"PROPERTYNAME"   //属性名字
#define PROPERTYTYPE @"PROPERTYTYPE"   //属性类型

#define MODELPREFIX @"BS"
#define MODELSUFFIX @"Model"


/*
 model类命名规范 前缀＋首字母大写模型(表)名＋后缀
 
 model的属性：
    支持数字（int\float\NSNumber等），字符串（NSString），bool类型，以及由此组成的数组
 
 数组类型的属性 命名规则 是 变量名 + __(双下划线) ＋ model key 字符串，比如 sender__user
*/


//基础模型类
@interface NSObject (FTModel)
+ (NSDictionary *)configInputMap; //子类实现 key:属性 value:网络参数

+ (NSDictionary*)getPropertys; //还回 该类的所有属性 会添加父类属性
+ (void)getSelfPropertys:(NSMutableArray *)pronames protypes:(NSMutableArray *)protypes isGetSuper:(BOOL)isGetSuper;//获取自身的属性 是否获取父类

//将JSON字典转变为model,如果字典参数为空，将返回nil
+ (id)modelWithJSONDictionary:(NSDictionary *)jsonDic;

//将model的转变为字典
- (NSDictionary*)JSONDictionary;
- (NSDictionary*)JSONDictionaryExcluded:(NSArray*)excluded;

+ (NSArray*)modelArrayWithJsonArray:(NSArray *)array;
+ (NSArray*)jsonArrayWithModelArray:(NSArray *)array;

//Last-Modified  If-Modified-Since  uptime
@end


