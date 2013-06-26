//
//  MissedPlan.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/5/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MissedItem.h"
#import "PlanAlert.h"
#import "MTLJSONAdapter.h"

@interface MissedPlan : MissedItem <MTLJSONSerializing>

@property (nonatomic, retain, readonly) PlanAlert *planAlert;

@end
