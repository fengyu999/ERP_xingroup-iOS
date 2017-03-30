//
//  NSStringChange.m
//  XinChuang
//
//  Created by xinchuang1 on 15/1/8.
//  Copyright (c) 2015年 Edward. All rights reserved.
//

#import "NSStringChange.h"

@implementation NSStringChange

 +( NSString *)HTTPBodyWithParameters:( NSDictionary *)parameters
{
    NSMutableArray *parametersArray = [[ NSMutableArray alloc ] init ];
    
    for ( NSString *key in [parameters allKeys ]) {
        id value = [parameters objectForKey :key];
        [parametersArray addObject :[ NSString stringWithFormat : @"%@=%@" ,key,value]];
    }
   return [parametersArray componentsJoinedByString : @"&" ];
   
}

+(NSString *)JSONStringFromDictionary:(NSDictionary *)dictionary{

    //NSJSONWritingPrettyPrinted:指定生成的JSON数据应使用空格旨在使输出更加可读。kNilOptions最紧凑的可能生成JSON表示。
    NSError *error;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:dictionary options:kNilOptions error:&error];
    if ([jsonData length] > 0 && error == nil){
//        NSLog(@"Successfully serialized the dictionary into data.");
        //NSData转换为String
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        NSLog(@"JSON String = %@", jsonString);
        return jsonString;
    } else if ([jsonData length] == 0 &&
               error == nil){
        NSLog(@"No data was returned after serialization.");
        return nil;
    } else if (error != nil){
        NSLog(@"An error happened = %@", error);
        return nil;
    }
    return nil;
}

@end
