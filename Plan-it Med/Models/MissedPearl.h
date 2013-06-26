//
//  MissedPearl.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/5/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MissedItem.h"
#import "Pearl.h"
#import "MTLJSONAdapter.h"

@interface MissedPearl : MissedItem <MTLJSONSerializing>

@property (nonatomic, retain, readonly) Pearl *pearl;

@end
