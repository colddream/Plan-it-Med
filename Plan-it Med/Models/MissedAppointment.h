//
//  MissedAppointment.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/5/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MissedItem.h"
#import "AppointmentAlert.h"
#import "MTLJSONAdapter.h"

@interface MissedAppointment : MissedItem <MTLJSONSerializing>

@property (nonatomic, retain, readonly) AppointmentAlert *appointmentAlert;

@end
