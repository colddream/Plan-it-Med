//
//  ModelHelper.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/3/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"

typedef enum {
    Monday = 1,
    TuesDay = 2,
    Wednesday = 3,
    Thursday = 4,
    Friday = 5,
    Saturday = 6,
    Sunday = 7
} WeekDayNumberType;

@interface ModelHelper

+ (NSDateFormatter *)dateFormatter;
+ (NSDateFormatter *)timeFormatter;
+ (NSDateFormatter *)dateTimeFormatter;
+ (NSValueTransformer *)DateJSONTransformer;
+ (NSValueTransformer *)TimeJSONTransformer;
+ (NSValueTransformer *)DateTimeJSONTransformer;
+ (NSValueTransformer *)NumberJSONTransformer;
+ (NSValueTransformer *)ClassJSONTransformer: (Class) class;
+ (NSValueTransformer *)ClassesJSONTransformer: (Class) class;
+ (NSValueTransformer *)URLJSONTransformer;
+ (NSString *)stringFromDayType:(NSArray *)dayType;
+ (NSArray *)dayTypeFromString:(NSString *)stringDayType;
+ (NSValueTransformer *)dayTypeStringJSONTransformer;
+ (NSValueTransformer *)NumbersJSONTransformer;

@end
