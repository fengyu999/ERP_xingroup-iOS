//
//  NSString+Hashing.h
//  XinChuang
//
//  Created by xinchuang1 on 15/1/8.
//  Copyright (c) 2015年 Edward. All rights reserved.
//
//
//has加密

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NJHashTypeMD5 = 0,
    NJHashTypeSHA1,
    NJHashTypeSHA256,
} NJHashType;

@interface NSString_Hashing : NSString

+ (NSString *)hash:(NSString *)str WithType:(NJHashType)type;

+ (NSString *)verify:(NSArray *)array WithType:(NJHashType)type;

@end
