//
//  Alert.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/4/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

typedef enum {
    PlanAlertType = 1,
    AppointmentAlertType = 2,
    LabAlertType = 3,
    GeneralAlertType = 4
} AlertType;


@interface Alert : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSNumber *ID;
@property (nonatomic, retain, readonly) NSNumber *active;
@property (nonatomic, retain, readonly) NSString *name;
@property (nonatomic, retain, readonly) NSNumber *type;

- (void)setNotification:(BOOL)isNotifiable withBlock:(void(^)(BOOL status, NSString *message, NSError *error))block;

@end
