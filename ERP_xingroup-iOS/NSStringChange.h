//
//  NSStringChange.h
//  XinChuang
//
//  Created by xinchuang1 on 15/1/8.
//  Copyright (c) 2015年 Edward. All rights reserved.
//
//
//
//将body转成json字符串

#import <Foundation/Foundation.h>

@interface NSStringChange : NSObject

+(NSString *)HTTPBodyWithParameters:(NSDictionary *)dic;

+(NSString *)JSONStringFromDictionary:(NSDictionary *)dic; //body转字符串

@end
