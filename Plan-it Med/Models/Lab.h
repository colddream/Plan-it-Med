//
//  Lab.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/27/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Lab : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSNumber *ID;
@property (nonatomic, retain, readonly) NSString *name;
@property (nonatomic, retain, readonly) NSDate *datetime;
@property (nonatomic, retain, readonly) NSNumber *doctorId;
@property (nonatomic, retain, readonly) NSNumber *alertId;

@end
