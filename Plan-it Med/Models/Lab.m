//
//  Lab.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/27/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Lab.h"
#import "ModelHelper.h"

@implementation Lab


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"labId",
        @"name": @"name",
        @"date": @"dateTime",
        @"doctorId": @"doctorId",
        @"alertId": @"labId"
    };
}

+ (NSValueTransformer *)IDJSONTransformer {
    
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)doctorIdJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)alertIdJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)dateTimeJSONTransformer {
    return [ModelHelper DateTimeJSONTransformer];
}

@end
