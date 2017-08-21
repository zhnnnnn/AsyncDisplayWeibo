//
//  NSString+date.m
//  HotCity
//
//  Created by zhn on 16/9/19.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "NSString+date.h"

typedef NS_ENUM(NSInteger,dateType) {
    dateTypeToday,// 今天
    dateTypeYesterday,// 昨天
    dateTypeThreedayAgo,// 前天
    dateTypeShowAllDate// 显示月份日期时间
};

@implementation NSString (date)

- (NSString *)compaireDateWithDateString:(NSString *)dateString{
    
    // 毫秒值转化为秒
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]/ 1000.0];
    NSString * newTime;
    dateType type = [self p_compareDate:date];
    switch (type) {
        case dateTypeToday:
        {
            NSDateFormatter * formatter = [self P_getCurrentFormatterWithType:dateTypeToday];
            newTime = [formatter stringFromDate:date];
        }
            break;
        case dateTypeYesterday:
        {
            NSDateFormatter * formatter = [self P_getCurrentFormatterWithType:dateTypeYesterday];
            newTime = [formatter stringFromDate:date];
        }
            break;
        case dateTypeThreedayAgo:
        {
            NSDateFormatter * formatter = [self P_getCurrentFormatterWithType:dateTypeThreedayAgo];
            newTime = [formatter stringFromDate:date];
        }
            break;
        case dateTypeShowAllDate:
        {
            NSDateFormatter * formatter = [self P_getCurrentFormatterWithType:dateTypeShowAllDate];
            newTime = [formatter stringFromDate:date];
        }
            break;
    }
    return newTime;
}


- (NSDateFormatter *)P_getCurrentFormatterWithType:(dateType)type{

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    switch (type) {
        case dateTypeToday:
        {
            [formatter setDateFormat:@"HH:mm"];
        }
            break;
        case dateTypeYesterday:
        {
            [formatter setDateFormat:@"昨天 HH:mm"];
        }
            break;
        case dateTypeThreedayAgo:
        {
            [formatter setDateFormat:@"前天 HH:mm"];
        }
            break;
        case dateTypeShowAllDate:
        {
            [formatter setDateFormat:@"MM月dd日 HH:mm"];
        }
            break;
    }
    return formatter;
}

- (dateType)p_compareDate:(NSDate *)date{
    
    NSTimeInterval  secondsPerDay =  24  *  60  *  60 ;
    NSDate * today = [[NSDate  alloc] init];
    NSDate * threeday, * yesterday;
    
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    threeday = [today dateByAddingTimeInterval:-(secondsPerDay * 2)];
    
   
    NSString * todayString = [[today  description ]  substringToIndex : 10 ];
    NSString * yesterdayString = [[yesterday  description ]  substringToIndex : 10 ];
    NSString * threedayString = [[threeday  description ]  substringToIndex : 10 ];
    
    NSString * dateString = [[date  description ]  substringToIndex : 10 ];
    if  ([dateString  isEqualToString :todayString])
    {
        return  dateTypeToday;
    }  else if  ([dateString  isEqualToString :yesterdayString])
    {
        return  dateTypeYesterday;
    } else if  ([dateString  isEqualToString :threedayString])
    {
        return  dateTypeThreedayAgo;
    }else{
        return dateTypeShowAllDate;
    }
}

@end
