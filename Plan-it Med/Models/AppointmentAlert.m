//
//  AppointmentAlert.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/4/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "AppointmentAlert.h"
#import "ModelHelper.h"

@interface AppointmentAlert()

@property (nonatomic, retain, readwrite) NSNumber *type;

@end

@implementation AppointmentAlert

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"appointmentId",
        @"active": @"active",
        @"name": @"name",
        @"type": @"type",
        @"appointmentId": @"appointmentId",
        @"appointment": @"appointment",
        @"dateTime": @"dateTime"
    };
}

- (id)init
{
    NSLog(@"AppointmentAlert Init");
    self = [super init];
    if (self) {
        self.type = @(AppointmentAlertType);
    }
    return self;
}

+ (NSValueTransformer *)appointmentIdJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)dateTimeJSONTransformer {
    return [ModelHelper DateTimeJSONTransformer];
}

+ (NSValueTransformer *)appointmentJSONTransformer {
    return [ModelHelper ClassJSONTransformer:Appointment.class];
}

@end
