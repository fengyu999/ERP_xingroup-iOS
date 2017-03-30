//
//  NSDictionary+MutableDeepCopy.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/5/16.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "NSDictionary+MutableDeepCopy.h"

@implementation NSDictionary(MutableDeepCopy)

- (NSMutableDictionary *)mutableDeepCopy
{
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:[self count]]; //这里的容量也只是个参考值,表示对大小的限制 大小是调用该方法的count
    NSArray *keys = [self allKeys]; //self就是个可变的字典
    for(id key in keys)
    {
        id dicValue = [self valueForKey:key]; //从 NSDictionary 取值的时候有两个方法objectForkey valueForKey
        id dicCopy = nil;
        if([dicValue respondsToSelector:@selector(mutableDeepCopy)]) //如果对象没有响应mutabledeepcopy 就创建一个可变副本 dicValue 有没有实现这个方法
        {
            dicCopy = [dicValue mutableDeepCopy];
        }
        else if([dicValue respondsToSelector:@selector(mutableCopy)])
        {
            dicCopy = [dicValue mutableCopy];
        }
        if(dicCopy ==nil)
        {
            dicCopy = [dicValue copy];
        }
        [mutableDictionary setValue:dicCopy forKey:key];
    }
    return mutableDictionary;
}

@end
