//
//  UserInfo.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/3/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "UserInfo.h"
#import "Schedule.h"
#import "ModelHelper.h"

@interface UserInfo()

@property (nonatomic, copy, readwrite) NSMutableDictionary *schedules;
@property (nonatomic, copy, readwrite) NSMutableArray *medicationAlerts;
@property (nonatomic, copy, readwrite) NSMutableArray *appointmentAlerts;
@property (nonatomic, copy, readwrite) NSMutableArray *labAlerts;
@property (nonatomic, copy, readwrite) NSMutableArray *generalAlerts;
@property (nonatomic, copy, readwrite) NSMutableArray *missedPlans;
@property (nonatomic, copy, readwrite) NSMutableArray *missedAppointments;
@property (nonatomic, copy, readwrite) NSMutableArray *missedLabs;
@property (nonatomic, copy, readwrite) NSMutableArray *missedPearls;
@property (nonatomic, copy, readwrite) NSMutableArray *unreadMessages;
@property (nonatomic, copy, readwrite) NSMutableArray *nowItems;
@property (nonatomic, copy, readwrite) NSMutableArray *teams;
@property (nonatomic, copy, readwrite) NSMutableArray *plans;
@property (nonatomic, copy, readwrite) NSMutableArray *favoriteQuotes;
@property (nonatomic, copy, readwrite) NSMutableArray *favoritePearls;
@property (nonatomic, copy, readwrite) NSNumber *reward;

@end

@implementation UserInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{};
}

- (void)scheduleForDate:(NSDate *)date withBlock:(void (^)(Schedule *schedule, NSString *message, NSError *error))block
{
    if (block) {
        NSString *dateString = [[ModelHelper dateFormatter] stringFromDate:date];
        if (self.schedules){
            if ([self.schedules.allKeys containsObject:dateString]){
                block([self.schedules objectForKey:dateString], nil, nil);
                
            } else {
                [Schedule scheduleForDate:date withBlock:^(Schedule *schedule, NSString *message, NSError *error) {
                    [self.schedules setValue:schedule forKey:dateString];
                    block(schedule, message, error);
                }];
            }
        } else {
            self.schedules = [[NSMutableDictionary alloc] init];
        }
    }
}

@end
