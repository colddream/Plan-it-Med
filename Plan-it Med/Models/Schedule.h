//
//  Schedule.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/27/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "Appointment.h"
#import "Lab.h"
#import "MTLJSONAdapter.h"

@interface Schedule : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSArray *plans;
@property (nonatomic, retain, readonly) Appointment *appointment;
@property (nonatomic, retain, readonly) Lab *lab;
@property (nonatomic, retain, readonly) NSDate *dateTime;


+(void)scheduleForDate:(NSDate *)date withBlock:(void (^)(Schedule *schedule, NSString *message, NSError *error))block;

@end
