//
//  NSString+TimeStamp.h
//  XinCap
//
//  Created by xinchuang1 on 15/2/4.
//  Copyright (c) 2015年 Roman Efimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString_TimeStamp : NSObject

+ (NSString *)theTimeStamp;//时间戳

+ (NSDate *)getDateTimeFromMilliSeconds:(NSNumber *) miliSecondnumber;     //将时间戳转化为NSDate

+ (NSString *)getDateStringWithDate:(NSDate *)date
                         DateFormat:(NSString *)formatString;  //将时间转为时间字符串

+ (NSString *)calDateTimeFromData:(NSDate *)paramStartDate; //获取当前时间间隔

+ (NSString *)calDateTimeLeftData:(NSDate *)paramStartDate; //获取当前时间与未来间隔

+ (NSString *)calDateTimeHourData:(NSDate *)paramStartDate; //获取当前时间与未来间隔(优化版,只显示小时)

+ (NSDate *)dateFromString:(NSString *)dateString;

+(NSString*)getCurrentMonthDay:(NSDate*)data; //return like xx月xx日

+(NSString*)getCurrentYearMonthDayHourMinusByNumberDate:(NSNumber*)NumberDate; // return like  2015-4-3 09:30


+(NSString*)getCurrentYearMonthDayHourMinus:(NSNumber*)NumberDate;   // return like  2015-4-3 10:19

+(NSString*)getCurrentYearMonthDay:(NSNumber*)NumberDate; // return like  2015-4-3


+(NSString*)getTimeFromNow:(NSNumber *)NumberDate;

+(NSString*)getHourMinusByNumberDate:(NSNumber*)NumberDate; // return like  17:20

@end
