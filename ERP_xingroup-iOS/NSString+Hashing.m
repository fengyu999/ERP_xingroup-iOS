//
//  NSString+Hashing.m
//  XinChuang
//
//  Created by xinchuang1 on 15/1/8.
//  Copyright (c) 2015年 Edward. All rights reserved.
//
//  加密

#import "NSString+Hashing.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString_Hashing

+ (NSString *)hash:(NSString *)str WithType:(NJHashType )type{

//    NSLog(@"加密前：%@",str);
    
    const char *ptf = [str UTF8String];
    NSUInteger bufferSize;
    switch (type) {
        case NJHashTypeMD5:
            bufferSize = CC_MD5_DIGEST_LENGTH;
            break;
        case NJHashTypeSHA1:
            bufferSize = CC_SHA1_DIGEST_LENGTH;
            break;
        case NJHashTypeSHA256:
            bufferSize = CC_SHA256_DIGEST_LENGTH;
            break;
        default:
            return nil;
            break;
    }
//    unsigned char buffer[buferSize];
    uint8_t buffer[bufferSize];
    
    //CC_MD5(str,strlen(str), r);，改成了     CC_MD5(str, (CC_LONG)strlen(str), r);
    switch (type) {
        case NJHashTypeMD5:
            CC_MD5(ptf,(CC_LONG) strlen(ptf), buffer);
            break;
        case NJHashTypeSHA1:
            CC_SHA1(ptf, (CC_LONG)strlen(ptf), buffer);
            break;
        case NJHashTypeSHA256:
            CC_SHA256(ptf, (CC_LONG)strlen(ptf), buffer);
            break;
        default:
            return nil;
            break;
    }
    NSMutableString *hashString = [NSMutableString stringWithCapacity:bufferSize*2];
    for (int i = 0; i < bufferSize; i ++) {
        [hashString appendFormat:@"%02x", buffer[i]];
    }
    
//    NSLog(@"加密后：%@",hashString);
    return hashString;
}


+ (NSString *)verify:(NSArray *)array WithType:(NJHashType)type{
    
    NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableString *mutString = [NSMutableString new];
    [sortedArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        if (0 == idx) {
            [mutString appendString:obj];
        }else{
            [mutString appendFormat:@"%@",obj];
        }
    }];
    NSString *result = [mutString copy];
    return [NSString_Hashing hash:result WithType:NJHashTypeSHA1];
}

@end
