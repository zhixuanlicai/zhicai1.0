//
//  FTModel.m
//  
//
//  Created by zgq on 13-3-19.
//  Copyright (c) 2013年 zgq. All rights reserved.
//

#import "FTModel.h"
#import <objc/runtime.h>

@implementation NSObject (FTModel)
+ (NSDictionary *)configInputMap
{
    return nil;
}
//将JSON字典转变为model,如果没有指定的类或则字典参数为空，将返回nil
+ (id)modelWithJSONDictionary:(NSDictionary *)jsonDic
{
    if (jsonDic == nil || jsonDic.count == 0) {
        return nil;
    }
    NSDictionary *dic = [self getPropertys];

    NSArray* pronames = [dic objectForKey:PROPERTYNAME];
    NSArray* protypes = [dic objectForKey:PROPERTYTYPE];

    NSObject* bindingModel = [[self alloc]init] ;
        for (NSInteger i=0; i<pronames.count; i++) {
            NSString* columeName = [pronames objectAtIndex:i];
            NSString* columeType = [protypes objectAtIndex:i];
            NSString* inputKey = [[self.class configInputMap] valueForKey:columeName]?:columeName;

            if ([columeType isEqualToString:@"NSArray"]) {
                
                NSMutableArray *subArray = [NSMutableArray array];

                //判断是否model数组
                NSArray *components = [columeName componentsSeparatedByString:@"__"];
                if (components.count > 1)
                {
                    NSString *subModelName  = [components lastObject];
                    NSString *keyName  = [components objectAtIndex:0];
                    NSArray *value = [jsonDic valueForKey:keyName];
                    if (![value isKindOfClass:[NSArray class]]) {
                        continue;
                    }
                    NSString *subClassName  = [NSString stringWithFormat:@"%@%@%@",MODELPREFIX,[subModelName capitalizedString],MODELSUFFIX];
                    if (NSClassFromString(subClassName) == nil)
                    {
                        NSLog(@"没有这个类%@",subClassName);
                        [subArray addObjectsFromArray:value];
                    }
                    else
                    {
                        for (NSDictionary * p in value) {
                            NSObject *model = [NSClassFromString(subClassName) modelWithJSONDictionary:p];
                            if (model)
                            {
                                [subArray addObject:model];
                            }
                        }
                    }
                }
                //数组类型是基础元素
                else                     
                {
                    NSArray *value = [jsonDic valueForKey:inputKey];
                    if (![value isKindOfClass:[NSArray class]]) {
                        continue;
                    }
                    for (NSObject * p in value) {
                        if (![p isEqual:[NSNull null]])
                        {
                            [subArray addObject:p];
                        }
                    }

                }
                
                [bindingModel setValue:subArray forKey:columeName];
            }
            //判断返回的元素中，含有自定义model变量，
            else if ([columeType hasPrefix:MODELPREFIX] && [columeType hasSuffix:MODELSUFFIX])
            {
                NSDictionary *value = [jsonDic valueForKey:inputKey];
                if ([value isKindOfClass:[NSDictionary class]])
                {
                    if (NSClassFromString(columeType) == nil)
                    {
                        NSLog(@"没有这个类%@",columeType);
                    }
                    else
                    {
                        NSObject *model = [NSClassFromString(columeType) modelWithJSONDictionary:value];
                        if (model)
                        {
                            [bindingModel setValue:model forKey:columeName];
                        }
                    }
                }
            }
            else if ([columeType isEqualToString:@"NSDictionary"]) {
                NSObject *value = [jsonDic valueForKey:inputKey];
                if ([value isKindOfClass:[NSDictionary class]]) {
                    [bindingModel setValue:value forKey:columeName];
                }
            }
            else if ([columeType isEqualToString:@"NSString"]) {
                NSObject *value =  [jsonDic valueForKey:inputKey];
                //数字类型转为字符串
                if ([value isKindOfClass:[NSNumber class]]) {
                    value = [(NSNumber*)value stringValue];
                }
                //value 值不符合，继续下一个
                if ([value isKindOfClass:[NSString class]])
                {
                    [bindingModel setValue:value forKey:columeName];
                }
            }
            else
            {
                NSObject *value = nil;

                if ([columeName isEqualToString:@"sign"]) {
                    value = [jsonDic valueForKey:@"signed"];
                }
                else
                {
                    value = [jsonDic valueForKey:inputKey];
                }

                
                //排除数组和字典的情况；
                //如果返回的元素，在model中的类型不是数组字典，返回的却是数组字典，报错置空
                if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]])
                {
                    NSLog(@"%@  不应该是字典或数组：%@",columeName,value);
                    value = nil;
                }
                //排除为空的情况
                if (value == [NSNull null] || value == nil)
                {
                    //如果是对象类型的就是nil
                    if ([NSClassFromString(columeType) isKindOfClass:[NSObject class]]) {
                        value = nil;
                    }
                    else  //如果是基础类型的int float bool，就是0
                    {
                        value = [NSNumber numberWithBool:FALSE];
                    }
                }
                //剩下的都是正常的有效值
                [bindingModel setValue:value forKey:columeName];
            }
        }
    return bindingModel;
}
- (NSDictionary*)JSONDictionaryExcluded:(NSArray*)excluded
{
    NSDictionary *prodic = [[self class] getPropertys];
    NSArray* pronames = [prodic objectForKey:PROPERTYNAME];
    NSArray* protypes = [prodic objectForKey:PROPERTYTYPE];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSInteger i=0; i<pronames.count; i++) {
        NSString* columeName = [pronames objectAtIndex:i];
        NSString* columeType = [protypes objectAtIndex:i];
        if ([excluded containsObject:columeName]) {
            continue;
        }
        if ([columeType isEqualToString:@"NSArray"]) {
            NSArray *subArray = [self valueForKey:columeName];
            if (![subArray isKindOfClass:[NSArray class]]) {
                continue;
            }
            NSMutableArray *subDicArray = [NSMutableArray array];
            for (NSObject *p in subArray) {
                if ([p isKindOfClass:[NSObject class]]) {
                    NSDictionary *subDic = [p JSONDictionary];
                    [subDicArray addObject:subDic];
                }
            }
            [dic setValue:subDicArray forKey:columeName];
        }
        else
        {
            [dic setValue:[self valueForKey:columeName] forKey:columeName];
        }
    }
    return dic;
 
}
//将model的转变为字典
- (NSDictionary*)JSONDictionary
{
    NSDictionary *prodic = [[self class] getPropertys];
    NSArray* pronames = [prodic objectForKey:PROPERTYNAME];
    NSArray* protypes = [prodic objectForKey:PROPERTYTYPE];

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSInteger i=0; i<pronames.count; i++) {
        NSString* columeName = [pronames objectAtIndex:i];
        NSString* columeType = [protypes objectAtIndex:i];
        if ([columeType isEqualToString:@"NSArray"]) {
            NSArray *subArray = [self valueForKey:columeName];
            if (![subArray isKindOfClass:[NSArray class]]) {
                continue;
            }
            NSMutableArray *subDicArray = [NSMutableArray array];
            for (NSObject *p in subArray) {
                if ([p isKindOfClass:[NSObject class]]) {
                    NSDictionary *subDic = [p JSONDictionary];
                    [subDicArray addObject:subDic];
                }
            }
            [dic setValue:subDicArray forKey:columeName];
        }
        else
        {
            [dic setValue:[self valueForKey:columeName] forKey:columeName];
        }
    }
    return dic;
}
//将model的数组转变为字典数组
+ (NSArray*)jsonArrayWithModelArray:(NSArray *)array
{
    if (array == nil || array.count == 0) {
        return nil;
    }
    NSMutableArray *mArray = [NSMutableArray array];
    
    for (NSObject * p in array) {
        NSDictionary *model = [p JSONDictionary];
        if (model) {
            [mArray addObject:model];
        }
    }
    return mArray;
}

//将字典组成的数组转变为model的数组
+ (NSArray*)modelArrayWithJsonArray:(NSArray *)array
{
    if (array == nil || ![array isKindOfClass:[NSArray class]] || array.count == 0) {
        return nil;
    }
    NSMutableArray *mArray = [NSMutableArray array];

    for (NSDictionary * p in array) {
        NSObject *model = [self modelWithJSONDictionary:p];
        if (model) {
            [mArray addObject:model];
        }
    }
    return mArray;
}

+(NSDictionary *)getPropertys
{
    NSMutableArray* pronames = [NSMutableArray array];
    NSMutableArray* protypes = [NSMutableArray array];
    NSDictionary* props = [NSDictionary dictionaryWithObjectsAndKeys:pronames,PROPERTYNAME,protypes,PROPERTYTYPE,nil];
    [self getSelfPropertys:pronames protypes:protypes isGetSuper:YES];
    return props;
}
+ (void)getSelfPropertys:(NSMutableArray *)pronames protypes:(NSMutableArray *)protypes isGetSuper:(BOOL)isGetSuper
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [pronames addObject:propertyName];
        NSString *propertyType = [NSString stringWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
        /*
         c char
         i int
         l long
         s short
         d double
         f float
         @ id //指针 对象
         ...  BOOL 获取到的表示 方式是 char
         .... ^i 表示  int*  一般都不会用到
         */
        
        if ([propertyType hasPrefix:@"T@"]) {
            [protypes addObject:[propertyType substringWithRange:NSMakeRange(3, [propertyType rangeOfString:@","].location-4)]];
        }
        else if ([propertyType hasPrefix:@"Ti"])
        {
            [protypes addObject:@"int"];
        }
        else if ([propertyType hasPrefix:@"Tf"])
        {
            [protypes addObject:@"float"];
        }
        else if([propertyType hasPrefix:@"Td"]) {
            [protypes addObject:@"double"];
        }
        else if([propertyType hasPrefix:@"Tl"])
        {
            [protypes addObject:@"long"];
        }
        else if ([propertyType hasPrefix:@"Tc"]) {
            [protypes addObject:@"char"];
        }
        else if([propertyType hasPrefix:@"Ts"])
        {
            [protypes addObject:@"short"];
        }
        else if([propertyType hasPrefix:@"TB"])
        {
            [protypes addObject:@"BOOL"];
        }
        else
        {
            NSLog(@"%@",propertyType);
        }
    }
    free(properties);
    if(isGetSuper && [self superclass] != [NSObject class])
    {
        [[self superclass] getSelfPropertys:pronames protypes:protypes isGetSuper:isGetSuper];
    }
}
//-(NSString *)description
//{
//    NSMutableString* sb = [NSMutableString stringWithCapacity:0];
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
//    for (i = 0; i < outCount; i++) {
//        objc_property_t property = properties[i];
//        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
//        [sb appendFormat:@" \n %@ : %@ ",propertyName,[self valueForKey:propertyName]];
//    }
//    free(properties);
//    return sb;
//}

@end

