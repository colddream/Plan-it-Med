//
//  Appointment.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/27/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Appointment.h"
#import "ModelHelper.h"

@implementation Appointment


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"appointmentId",
        @"doctorId": @"doctorId",
        @"name": @"name",
        @"dateTime": @"dateTime",
        @"alertId": @"appointmentId"
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
