//
//  NSString+TimeStamp.m
//  XinCap
//
//  Created by xinchuang1 on 15/2/4.
//  Copyright (c) 2015年 Roman Efimov. All rights reserved.
//
//  时间戳

#import "NSString+TimeStamp.h"

@implementation NSString_TimeStamp

//android可用时间戳，取到毫秒
+ (NSString *)theTimeStamp//时间戳
{
    //获取当前时间 （当前时区）
    NSDate *date = [NSDate date];

    NSString *timeStamp = [NSString stringWithFormat:@"%lld",[self getDateTimeTOMilliSeconds:date]];

    return timeStamp;
}

+ (NSDate *)getDateTimeFromMilliSeconds:(NSNumber *) miliSecondnumber
{
    NSMutableString *timeString= [NSMutableString stringWithFormat:@"%@",miliSecondnumber];
    if (timeString.length < 10) {
        [timeString appendString:@"0000000000"];
    }
    long long miliSeconds = [[timeString substringToIndex:10] intValue];
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli;
    //    NSLog(@"seconds=%f",seconds);
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

+(long long)getDateTimeTOMilliSeconds:(NSDate *)datetime
{
    NSTimeInterval interval = [datetime timeIntervalSince1970];
//    NSLog(@"interval=%f",interval);
    long long totalMilliseconds = interval ;
    //    NSLog(@"totalMilliseconds=%llu",totalMilliseconds);
    return totalMilliseconds;
}


//计算时间间隔
//@paaram   paramStartDate            用于转换的时间
+ (NSString *)calDateTimeFromData:(NSDate *)paramStartDate{
    
    //获取当前时间
    NSDate *date = [NSDate date];//源日期
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];//得到源日期与世界标准时间的偏移量
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];//以当前NSDate对象为基准，偏移多少秒后得到的新NSDate对象
//    NSLog(@"enddate=%@",localeDate);
    
//    //转化为单前时区时间
//    NSTimeZone *startZone = [NSTimeZone systemTimeZone];//源日期
//    NSInteger startInterval = [startZone secondsFromGMTForDate: paramStartDate];//得到源日期与世界标准时间的偏移量
//    NSDate *startLocaleDate = [paramStartDate  dateByAddingTimeInterval: startInterval];
    
//    NSLog(@"\n 当前时间 %@：\n 发表时间：%@",date,startLocaleDate);
    NSString *strResult=nil;
    
    NSCalendar *chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger unitFlags =  NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond | NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *DateComponent = [chineseClendar components:unitFlags fromDate:paramStartDate toDate:date options:0];
    
    NSInteger diffHour = [DateComponent hour];
    
    NSInteger diffMin    = [DateComponent minute];
    
    NSInteger diffSec   = [DateComponent second];
    
    NSInteger diffDay   = [DateComponent day];
    
    NSInteger diffMon  = [DateComponent month];
    
    NSInteger diffYear = [DateComponent year];
    
    if (diffYear>0) {
        strResult=[NSString stringWithFormat:@"%ld年前",(long)diffYear];
        return strResult;
    }else if(diffMon>0){
        strResult=[NSString stringWithFormat:@"%ld月前",(long)diffMon];
        return strResult;
    }else if(diffDay>0){
        strResult=[NSString stringWithFormat:@"%ld天前",(long)diffDay];
        return strResult;
    }else if(diffHour>0){
        strResult=[NSString stringWithFormat:@"%ld小时前",(long)diffHour];
        return strResult;
    }else if(diffMin>0){
        strResult=[NSString stringWithFormat:@"%ld分钟前",(long)diffMin];
        return strResult;
    }else if(diffSec>0){
        strResult=[NSString stringWithFormat:@"%ld秒前",(long)diffSec];
        return strResult;
    }else{
        strResult=[NSString stringWithFormat:@"未知时间"];
        return strResult;
    }
}


//将date时间戳转变成时间字符串
//@paaram   date            用于转换的时间
//@param    formatString    时间格式(yyyy-MM-dd HH:mm:ss)
//@return   NSString        返回字字符如（2012－8－8 11:11:11）
+ (NSString *)getDateStringWithDate:(NSDate *)date
                         DateFormat:(NSString *)formatString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatString];
    NSString *dateString = [dateFormat stringFromDate:date];
    NSLog(@"date: %@", dateString);
    return dateString;
}
//获取当前时间与未来间隔

+ (NSString *)calDateTimeLeftData:(NSDate *)paramStartDate
{
    //获取当前时间
    NSDate *date = [NSDate date];//源日期
//   NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];//得到源日期与世界标准时间的偏移量
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];//以当前NSDate对象为基准，偏移多少秒后得到的新NSDate对象
    //    NSLog(@"enddate=%@",localeDate);
    
//    //转化为单前时区时间
//    NSTimeZone *startZone = [NSTimeZone systemTimeZone];//源日期
//    NSInteger startInterval = [startZone secondsFromGMTForDate: paramStartDate];//得到源日期与世界标准时间的偏移量
//    NSDate *startLocaleDate = [paramStartDate  dateByAddingTimeInterval: startInterval];
  
    //    NSLog(@"\n 当前时间 %@：\n 发表时间：%@",date,startLocaleDate);
    NSString *strResult=nil;
    
    NSCalendar *chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger unitFlags = NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *DateComponent = [chineseClendar components:unitFlags fromDate:date toDate:paramStartDate options:NSCalendarMatchStrictly];
    
    

    NSInteger diffSec   = [DateComponent second];
    
    NSInteger diffMin   = [DateComponent minute];
    
    NSInteger diffHour  = [DateComponent hour];
    
    NSInteger diffDay   = [DateComponent day];
    
    NSInteger diffMon   = [DateComponent month];
    
    NSInteger diffYear  = [DateComponent year];
    
    if (diffYear>0) {
        strResult=[NSString stringWithFormat:@"%ld年%ld月%ld天%ld小时",(long)diffYear,(long)diffMon,(long)diffDay,(long)diffHour];
        return strResult;
    }else if(diffMon>0){
        strResult=[NSString stringWithFormat:@"%ld月%ld天%ld小时",(long)diffMon,(long)diffDay,(long)diffHour];
        return strResult;
    }else if(diffDay>0){
        strResult=[NSString stringWithFormat:@"%ld天%ld小时",(long)diffDay,(long)diffHour];
        return strResult;
    }else if(diffHour>0){
        strResult=[NSString stringWithFormat:@"%ld小时",(long)diffHour];
        return strResult;
    }else if(diffMin>0){
        strResult=[NSString stringWithFormat:@"%ld分钟",(long)diffMin];
        return strResult;
    }else if(diffSec>0){
        strResult=[NSString stringWithFormat:@"%ld秒",(long)diffSec];
        return strResult;
    }else{
        strResult=[NSString stringWithFormat:@"已截止"];
        return strResult;
    }
    

}

//获取当前时间与未来间隔（优化版）
+ (NSString *)calDateTimeHourData:(NSDate *)paramStartDate
{
    //获取当前时间
    NSDate *date = [NSDate date];//源日期
    //   NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate: date];//得到源日期与世界标准时间的偏移量
    //    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];//以当前NSDate对象为基准，偏移多少秒后得到的新NSDate对象
    //    NSLog(@"enddate=%@",localeDate);
    
    //    //转化为单前时区时间
    //    NSTimeZone *startZone = [NSTimeZone systemTimeZone];//源日期
    //    NSInteger startInterval = [startZone secondsFromGMTForDate: paramStartDate];//得到源日期与世界标准时间的偏移量
    //    NSDate *startLocaleDate = [paramStartDate  dateByAddingTimeInterval: startInterval];
    
    //    NSLog(@"\n 当前时间 %@：\n 发表时间：%@",date,startLocaleDate);
    NSString *strResult=nil;
    
    NSCalendar *chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger unitFlags = NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *DateComponent = [chineseClendar components:unitFlags fromDate:date toDate:paramStartDate options:NSCalendarMatchStrictly];
    
    
    
    NSInteger diffSec   = [DateComponent second];
    
    NSInteger diffMin   = [DateComponent minute];
    
    NSInteger diffHour  = [DateComponent hour];
    
    NSInteger diffDay   = [DateComponent day];
    
    NSInteger diffMon   = [DateComponent month];
    
    NSInteger diffYear  = [DateComponent year];
    
    if (diffYear>0) {
        strResult=[NSString stringWithFormat:@"%ld年",(long)diffYear];
        return strResult;
    }else if(diffMon>0){
        strResult=[NSString stringWithFormat:@"%ld月",(long)diffMon];
        return strResult;
    }else if(diffDay>0){
        strResult=[NSString stringWithFormat:@"%ld天",(long)diffDay];
        return strResult;
    }else if(diffHour>0){
        strResult=[NSString stringWithFormat:@"%ld小时",(long)diffHour];
        return strResult;
    }else if(diffMin>0){
        strResult=[NSString stringWithFormat:@"%ld分钟",(long)diffMin];
        return strResult;
    }else if(diffSec>0){
        strResult=[NSString stringWithFormat:@"%ld秒",(long)diffSec];
        return strResult;
    }else{
        strResult=[NSString stringWithFormat:@"已截止"];
        return strResult;
    }
    
    
}


+(NSString*)getTimeFromNow:(NSNumber *)NumberDate
{
    
    NSDate *date = [self getDateTimeFromMilliSeconds:NumberDate];
    
    time_t createdAt = (time_t) [date timeIntervalSince1970];
    
    NSString *_timestamp;
    // Calculate distance time string
    //
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"1分钟前"];
//        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"秒前" : @"秒前"];
    }
    
    else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"分钟前" : @"分钟前"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"小时前" : @"小时前"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"天前" : @"天前"];
    }
    else if (distance < 60 * 60 * 24 * 365) {
//        distance = distance / 60 / 60 / 24 / 7;
//        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"周前" : @"周前"];
        
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            //            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setDateFormat: @"MM-dd"];
            //  [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        _timestamp = [dateFormatter stringFromDate:date];
        
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            
            [dateFormatter setDateFormat: @"yyyy-MM-dd"];
            //  [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        _timestamp = [dateFormatter stringFromDate:date];
    }
    return _timestamp;
    
    
    
}


+(NSString*)getCurrentMonthDay:(NSDate*)data //xx月xx日
{
    
    
    NSCalendar *localCalendar= [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSTimeZoneCalendarUnit|NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    
    NSDateComponents *comps = [localCalendar components:unitFlags fromDate:data];
    
    return [NSString stringWithFormat:@"%lu月%lu日",comps.month,comps.day] ;
    
}

+(NSString*)getCurrentYearMonthDayHourMinusByNumberDate:(NSNumber*)NumberDate // return like  2015-4-3 
{
    
    NSDate *date = [self getDateTimeFromMilliSeconds:NumberDate];
    
    NSCalendar *localCalendar= [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSTimeZoneCalendarUnit|NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    
    NSDateComponents *comps = [localCalendar components:unitFlags fromDate:date];
    
    return [NSString stringWithFormat:@"%lu-%lu-%lu",comps.year,comps.month,comps.day] ;
    
}
+(NSString*)getHourMinusByNumberDate:(NSNumber*)NumberDate // return like  17:20
{
    
    NSDate *date = [self getDateTimeFromMilliSeconds:NumberDate];
    
    NSCalendar *localCalendar= [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSTimeZoneCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit;
    
    NSDateComponents *comps = [localCalendar components:unitFlags fromDate:date];
    if(comps.hour<=9 && comps.minute>9)
    {
         return [NSString stringWithFormat:@"0%lu : %lu",comps.hour,comps.minute] ;
    }
    else if(comps.minute<=9&& comps.hour>9)
    {
        return [NSString stringWithFormat:@"%lu : 0%lu",comps.hour,comps.minute] ;
    }else if(comps.minute<=9 && comps.hour<=9)
    {
        return [NSString stringWithFormat:@"0%lu : 0%lu",comps.hour,comps.minute] ;
    }else
    {
      return [NSString stringWithFormat:@"%lu : %lu",comps.hour,comps.minute] ;
    }
    
}

+(NSString*)getCurrentYearMonthDayHourMinus:(NSNumber*)NumberDate // return like  2015-4-3 10:19
{
    
    NSDate *date = [self getDateTimeFromMilliSeconds:NumberDate];
    
    NSCalendar *localCalendar= [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSTimeZoneCalendarUnit|NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    
    NSDateComponents *comps = [localCalendar components:unitFlags fromDate:date];
    
    if(comps.minute<=9)
    {
          return [NSString stringWithFormat:@"%lu-%lu-%lu %lu:0%lu",comps.year,comps.month,comps.day ,comps.hour,comps.minute] ;
    }
    return [NSString stringWithFormat:@"%lu-%lu-%lu %lu:%lu",comps.year,comps.month,comps.day ,comps.hour,comps.minute] ;
    
}

+(NSString*)getCurrentYearMonthDay:(NSNumber*)NumberDate // return like  2015-4-3
{
    
    NSDate *date = [self getDateTimeFromMilliSeconds:NumberDate];
    
    NSCalendar *localCalendar= [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSTimeZoneCalendarUnit|NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit;
    
    NSDateComponents *comps = [localCalendar components:unitFlags fromDate:date];
    
    if(comps.minute<=9)
    {
        return [NSString stringWithFormat:@"%lu-%lu-%lu ",comps.year,comps.month,comps.day] ;
    }
    return [NSString stringWithFormat:@"%lu-%lu-%lu ",comps.year,comps.month,comps.day] ;
    
}


+ (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
}


@end
