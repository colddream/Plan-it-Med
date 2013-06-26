//
//  DoseData.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/3/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "DoseData.h"
#import "MTLValueTransformer.h"
#import "ModelHelper.h"

@implementation DoseData


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"name": @"name",
        @"dayType": @"dayType",
        @"time": @"time",
        @"alertIds": @"alertIds",
    };
}

+ (NSValueTransformer *)timeJSONTransformer {
    return [ModelHelper TimeJSONTransformer];
}

+ (NSValueTransformer *)dayTypeJSONTransformer {
    return [ModelHelper NumbersJSONTransformer];
}

+ (NSValueTransformer *)alertIdsJSONTransformer {
    return [ModelHelper NumbersJSONTransformer];
}

@end
