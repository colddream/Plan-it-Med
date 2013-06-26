//
//  NowItem.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/5/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface NowItem : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSNumber *alertId;
@property (nonatomic, retain, readonly) NSNumber *medicationId;
@property (nonatomic, retain, readonly) NSString *medicationName;
@property (nonatomic, retain, readonly) NSString *doseName;

@end
