//
//  Schedule.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/27/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Schedule.h"
#import "CommonClient.h"
#import "ModelHelper.h"
#import "MTLJSONAdapter.h"
#import "Plan.h"

static NSString *schedulePath = @"schedule";

@implementation Schedule

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"plans": @"medication",
        @"appointment": @"appointment",
        @"lab": @"lab",
        @"dateTime": @"dateTime"
    };
}

+ (NSValueTransformer *)plansJSONTransformer {
    return [ModelHelper ClassesJSONTransformer:Plan.class];
}

+ (NSValueTransformer *)appointmentJSONTransformer {
    return [ModelHelper ClassJSONTransformer:Appointment.class];
}

+ (NSValueTransformer *)labJSONTransformer {
    return [ModelHelper ClassJSONTransformer:Lab.class];
}

+ (NSValueTransformer *)dateTimeJSONTransformer {
    return [ModelHelper DateTimeJSONTransformer];
}

+ (void)scheduleForDate:(NSDate *)date withBlock:(void (^)(Schedule *schedule, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    NSString *scheduleForDatePath = [[NSString alloc] initWithFormat:@"%@?dateTime=%@",schedulePath,[[ModelHelper dateFormatter] stringFromDate:date]];
    
    [commonClient getPath:scheduleForDatePath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (block) {
            BOOL status = [[responseObject valueForKey:@"status"] integerValue];
            if (status) {
                NSDictionary *data = [responseObject valueForKey:@"data"];
                Schedule *schedule = [MTLJSONAdapter modelOfClass:Schedule.class fromJSONDictionary:data error:nil];
                block(schedule, nil, nil);
            } else {
                NSString *message = [responseObject valueForKey:@"msg"];
                block(nil, message, nil);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, nil, error);
        }
    }];
}

@end
