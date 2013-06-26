//
//  MissedLab.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/5/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MissedLab.h"
#import "ModelHelper.h"

@interface MissedLab()

@property (nonatomic, retain, readwrite) NSNumber *alertType;

@end

@implementation MissedLab

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"alertId": @"alertId",
        @"labAlert": @"labAlert",
        @"name": @"name",
        @"dateTime": @"dateTime"
    };
}

- (id)init
{
    self = [super init];
    if (!self) {
        self.alertType = @(LabAlertType);
    }
    return self;
}

+ (NSValueTransformer *)labAlertJSONTransformer {
    return [ModelHelper ClassJSONTransformer:LabAlert.class];
}

@end
