//
//  LabAlert.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/4/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "LabAlert.h"
#import "ModelHelper.h"

@interface LabAlert()

@property (nonatomic, retain, readwrite) NSNumber *type;

@end

@implementation LabAlert

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"labId",
        @"active": @"active",
        @"name": @"name",
        @"type": @"type",
        @"labId": @"labId",
        @"lab": @"lab",
        @"dateTime": @"dateTime"
    };
}

- (id)init
{
    NSLog(@"LabAlert Init");
    self = [super init];
    if (self) {
        self.type = @(LabAlertType);
    }
    return self;
}

+ (NSValueTransformer *)labIdJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)dateTimeJSONTransformer {
    return [ModelHelper DateTimeJSONTransformer];
}

+ (NSValueTransformer *)labJSONTransformer {
    return [ModelHelper ClassJSONTransformer:Lab.class];
}


@end
