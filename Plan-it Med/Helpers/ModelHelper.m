//
//  ModelHelper.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/3/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "ModelHelper.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation ModelHelper

+ (NSDateFormatter *)baseDateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    return dateFormatter;
}

+ (NSDateFormatter *)dateFormatter {
    self.baseDateFormatter.dateFormat = @"yyyy-MM-dd";
    return self.baseDateFormatter;
}

+ (NSDateFormatter *)dateTimeFormatter {
    self.baseDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return self.baseDateFormatter;
}

+ (NSDateFormatter *)timeFormatter {
    self.baseDateFormatter.dateFormat = @"HH:mm:ss";
    return self.baseDateFormatter;
}

+ (NSValueTransformer *)DateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)DateTimeJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateTimeFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateTimeFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)TimeJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.timeFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.timeFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)NumberJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return @(str.integerValue);
    } reverseBlock:^(NSNumber *number) {
        return number.stringValue;
    }];
}

+ (NSValueTransformer *)ClassJSONTransformer: (Class) class
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:class];
}

+ (NSValueTransformer *)ClassesJSONTransformer: (Class) class
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:class];
}

+ (NSValueTransformer *)URLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)NumbersJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *numberStrings) {
        return [self NumbersFromNumberStrings:numberStrings];
    } reverseBlock:^(NSArray *numbers) {
        return [self NumberStringsFromNumbers:numbers];
    }];
}

+ (NSArray *)NumbersFromNumberStrings:(NSArray *)numberStrings
{
    NSMutableArray *numbers = [[NSMutableArray alloc] init];
    for (NSString *numberString in numberStrings) {
        NSNumber *number = @([numberString integerValue]);
        [numbers addObject:number];
    }
    return numbers;
}

+ (NSArray *)NumberStringsFromNumbers:(NSArray *)numbers
{
    NSMutableArray *numberStrings = [[NSMutableArray alloc] init];
    
    for (NSNumber *number in numbers) {
        NSString *numberString = [number stringValue];
        [numberStrings addObject:numberString];
    }
    return numberStrings;
}

+ (NSValueTransformer *)dayTypeStringJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self dayTypeFromString:str];
    } reverseBlock:^(NSArray *dayType) {
        return [self stringFromDayType:dayType];
    }];
}

+ (NSString *)stringFromDayType:(NSArray *)dayType
{
    NSDictionary *dayTypeToString = @{
        @(Monday) : @"Mon",
        @(TuesDay) : @"Tue",
        @(Wednesday) : @"Wed",
        @(Thursday) : @"Thu",
        @(Friday) : @"Fri",
        @(Saturday) : @"Sat",
        @(Sunday) : @"Sun"
    };
    
    NSString *dayTypeString = @"";
    for (int i=0; i<[dayType count]; i++) {
        NSNumber *weekDay = dayType[i];
        if ([weekDay integerValue] >=1 && [weekDay integerValue] <= 7) {
            if (i == 0) {
                dayTypeString = dayTypeToString[weekDay];
            } else {
                dayTypeString = [dayTypeString stringByAppendingFormat:@",%@",dayTypeToString[weekDay]];   
            }
            
        }
    }
    
    return dayTypeString;
}

+ (NSArray *)dayTypeFromString:(NSString *)stringDayType
{
    NSDictionary *stringToDayType = @{
        @"Mon" : @(Monday),
        @"Tue" : @(TuesDay),
        @"Wed" : @(Wednesday),
        @"Thu" : @(Thursday),
        @"Fri" : @(Friday),
        @"Sat" : @(Saturday),
        @"Sun" : @(Sunday)
    };
    NSMutableArray *dayType = [[NSMutableArray alloc] init];
    NSArray *components = [stringDayType componentsSeparatedByString:@","];
    
    for (NSString *component in components) {
        [dayType addObject:stringToDayType[component]];
    }
    
    return dayType;
}

@end
