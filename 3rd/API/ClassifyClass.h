//
//  ClassifyClass.h
//  ShareWedding
//
//  Created by yyt on 14-9-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
    MenuStyleNone =0,
    MenuStylePathLeft =1,//path left
    MenuStylePathRight =2,
    
}MenuStyle;

typedef enum{
    
    RootViewControllerStyleSame = 0, //二级页面一样
    RootViewControllerStyleList = 1, //列表样式
    RootViewControllerStyleReader =2, //详情阅读类型
    RootViewControllerStyleWeddingCard = 3,//喜帖类型
    
}RootViewControllerStyle;


@interface ClassifyClass : NSObject

@end
