//
//  DoseData.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/3/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface DoseData : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSString *name;
@property (nonatomic, retain, readonly) NSArray *dayType;
@property (nonatomic, retain, readonly) NSDate *time;
@property (nonatomic, retain, readonly) NSArray *alertIds;

@end
