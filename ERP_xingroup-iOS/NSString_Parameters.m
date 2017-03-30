//
//  NSString_Parameters.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/24.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "NSString_Parameters.h"
#import "OpenUDID.h"
#import "NSString+Hashing.h"

@implementation NSString_Parameters

+ (NSString *) getResultURLWithPath:(NSString *)urlPath baseURL:(NSString *)baseURL paramers:(NSDictionary *)parameters andBody:(NSDictionary *)body{
    
    NSString *systime = [NSString_TimeStamp theTimeStamp];
    NSString *openid = [OpenUDID value];
    
    NSMutableDictionary *newDic = [NSMutableDictionary new];
    if (parameters != nil) {
        [newDic addEntriesFromDictionary:parameters];
    }
    [newDic setObject:systime forKey:@"systemid"];      //systemid
    [newDic setObject:openid forKey:@"openid"];         //openid
    
    NSMutableDictionary *verifyDic = [newDic mutableCopy];
    if (body != nil) {
        NSString *bodyValue = [NSStringChange JSONStringFromDictionary:body];   //body 转成json格式
        [verifyDic setObject:bodyValue forKey:@"body"];
        
        NSLog(@"body is %@",bodyValue);
    }
    
    NSString *verify = [NSString_Parameters verify:verifyDic];     //加密
    [newDic setObject:verify forKey:@"verify"];
    
    NSString *parmString = [NSStringChange HTTPBodyWithParameters:newDic] ;
    NSString *resultStr =  [NSString stringWithFormat:@"%@%@?%@",baseURL,urlPath,parmString];
    resultStr = [resultStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return resultStr;
}

+(NSString *)verify:(NSDictionary *)paramers{
    NSMutableArray *verArray = [NSMutableArray new];
    [paramers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *str = [NSString stringWithFormat:@"%@:%@",key,obj];
        [verArray addObject:str];
    }];
    NSString *verify = [NSString_Hashing verify:verArray WithType:NJHashTypeSHA1];
    return verify;
}

//只加密
+ (NSString *) getVerifyURLWithPath:(NSString *)urlPath baseURL:(NSString *)baseURL paramers:(NSDictionary *)parameters andBody:(NSDictionary *)body;{
    
    NSMutableDictionary *newDic = [NSMutableDictionary new];
    if (parameters != nil) {
        [newDic addEntriesFromDictionary:parameters];
    }
    
    NSMutableDictionary *verifyDic = [newDic mutableCopy];
    if (body != nil) {
        NSString *bodyValue = [NSStringChange JSONStringFromDictionary:body];   //body 转成json格式
        [verifyDic setObject:bodyValue forKey:@"body"];
        
        NSLog(@"body is %@",bodyValue);
    }
    
    NSString *verify = [NSString_Parameters verify:verifyDic];     //加密
    [newDic setObject:verify forKey:@"verify"];
    
    NSString *parmString = [NSStringChange HTTPBodyWithParameters:newDic] ;
    NSString *resultStr =  [NSString stringWithFormat:@"%@%@?%@",baseURL,urlPath,parmString];
    resultStr = [resultStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    return resultStr;
}

@end
