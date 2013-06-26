//
//  MissedItem.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/5/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface MissedItem : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSNumber *alertId;
@property (nonatomic, retain, readonly) NSString *alertType;
@property (nonatomic, retain, readonly) NSString *name;
@property (nonatomic, retain, readonly) NSDate *dateTime;

@end
