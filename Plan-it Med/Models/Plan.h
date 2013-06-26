//
//  Plan.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/3/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "Medication.h"
#import "MTLJSONAdapter.h"

@interface Plan : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSNumber *ID;
@property (nonatomic, retain, readonly) NSNumber *medicationId;
@property (nonatomic, retain, readonly) Medication *medication;
@property (nonatomic, retain, readonly) NSString *medicationName;
@property (nonatomic, retain, readonly) NSNumber *doctorId;
@property (nonatomic, retain, readonly) NSString *dose;
@property (nonatomic, retain, readonly) NSString *choice;
@property (nonatomic, retain, readonly) NSString *route;
@property (nonatomic, retain, readonly) NSDate *startTime;//dateTime
@property (nonatomic, retain, readonly) NSNumber *dayRegimen;
@property (nonatomic, retain, readonly) NSNumber *timePerDay;
@property (nonatomic, retain, readonly) NSArray *doseData;

@end
