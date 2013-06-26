//
//  AppointmentAlert.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/4/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Appointment.h"
#import "Alert.h"
#import "MTLJSONAdapter.h"

@interface AppointmentAlert : Alert <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSNumber *appointmentId;
@property (nonatomic, retain, readonly) Appointment *appointment;
@property (nonatomic, retain, readonly) NSDate *dateTime;

@end
