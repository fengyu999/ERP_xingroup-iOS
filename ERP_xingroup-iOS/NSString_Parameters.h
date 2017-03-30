//
//  NSString_Parameters.h
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/24.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString_Parameters : NSString

+ (NSString *) getResultURLWithPath:(NSString *)urlPath baseURL:(NSString *)baseURL paramers:(NSDictionary *)parameters andBody:(NSDictionary *)body;
+ (NSString *) getVerifyURLWithPath:(NSString *)urlPath baseURL:(NSString *)baseURL paramers:(NSDictionary *)parameters andBody:(NSDictionary *)body;

@end
