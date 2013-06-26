//
//  MissedPlan.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/5/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MissedPlan.h"
#import "ModelHelper.h"

@interface MissedPlan()

@property (nonatomic, retain, readwrite) NSNumber *alertType;

@end

@implementation MissedPlan

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"alertId": @"alertId",
        @"planAlert": @"planAlert",
        @"name": @"name",
        @"dateTime": @"dateTime",
        @"alertType": @"alertType"
    };
}

- (id)init
{
    self = [super init];
    if (!self) {
        self.alertType = @(PlanAlertType);
    }
    return self;
}

+ (NSValueTransformer *)planAlertJSONTransformer {
    return [ModelHelper ClassJSONTransformer:PlanAlert.class];
}

@end
