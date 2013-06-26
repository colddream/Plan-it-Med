//
//  PlanAlert.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/4/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Alert.h"
#import "Plan.h"
#import "MTLJSONAdapter.h"

@interface PlanAlert : Alert <MTLJSONSerializing>


@property (nonatomic, retain, readonly) NSNumber *planId;
@property (nonatomic, retain, readonly) Plan *plan;
@property (nonatomic, retain, readonly) NSArray *dayType;


@end
