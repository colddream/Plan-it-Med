//
//  PlanAlert.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/4/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "PlanAlert.h"
#import "ModelHelper.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@interface PlanAlert()

@property (nonatomic, retain, readwrite) NSNumber *type;

@end

@implementation PlanAlert

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"alertId",
        @"active": @"active",
        @"name": @"medicationName",
        @"type": @"type",
        @"planId": @"planId",
        @"plan": @"plan",
        @"dayType": @"dayType"
    };
}

- (id)init
{
    NSLog(@"planAlert Init");
    self = [super init];
    if (self) {
        self.type = @(PlanAlertType);
    }
    return self;
}


+ (NSValueTransformer *)planIdJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

- (NSValueTransformer *)planJSONTransformer
{
    return [ModelHelper ClassJSONTransformer:Plan.class];
}

- (NSValueTransformer *)dayTypeJSONTransformer
{
    return [ModelHelper NumbersJSONTransformer];
}

@end
