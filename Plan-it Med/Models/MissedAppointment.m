//
//  MissedAppointment.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/5/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MissedAppointment.h"
#import "ModelHelper.h"

@interface MissedAppointment()

@property (nonatomic, retain, readwrite) NSNumber *alertType;

@end

@implementation MissedAppointment

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"alertId": @"alertId",
        @"appointmentAlert": @"appointmentAlert",
        @"name": @"name",
        @"dateTime": @"dateTime"
    };
}

- (id)init
{
    self = [super init];
    if (!self) {
        self.alertType = @(AppointmentAlertType);
    }
    return self;
}

+ (NSValueTransformer *)appointmentAlertJSONTransformer {
    return [ModelHelper ClassJSONTransformer:AppointmentAlert.class];
}

@end
