//
//  UserInfo.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/3/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "Schedule.h"
#import "MTLJSONAdapter.h"

@interface UserInfo : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSMutableDictionary *schedules;
@property (nonatomic, retain, readonly) NSMutableArray *planAlerts;
@property (nonatomic, retain, readonly) NSMutableArray *appointmentAlerts;
@property (nonatomic, retain, readonly) NSMutableArray *labAlerts;
@property (nonatomic, retain, readonly) NSMutableArray *generalAlerts;
@property (nonatomic, retain, readonly) NSMutableArray *missedPlans;
@property (nonatomic, retain, readonly) NSMutableArray *missedAppointments;
@property (nonatomic, retain, readonly) NSMutableArray *missedLabs;
@property (nonatomic, retain, readonly) NSMutableArray *missedPearls;
@property (nonatomic, retain, readonly) NSMutableArray *unreadMessages;
@property (nonatomic, retain, readonly) NSMutableArray *nowItems;
@property (nonatomic, retain, readonly) NSMutableArray *teams;
@property (nonatomic, retain, readonly) NSMutableArray *plans;
@property (nonatomic, retain, readonly) NSMutableArray *favoriteQuotes;
@property (nonatomic, retain, readonly) NSMutableArray *favoritePearls;
@property (nonatomic, retain, readonly) NSNumber *reward;
@property (nonatomic, retain, readonly) NSNumber *missedItemsCount;
@property (nonatomic, retain, readonly) NSNumber *nowItemsCount;
@property (nonatomic, retain, readonly) NSNumber *unreadMessagesCount;


-(void)scheduleForDate:(NSDate *)date withBlock:(void (^)(Schedule *schedule, NSString *message, NSError *error))block;

@end
