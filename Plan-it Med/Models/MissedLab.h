//
//  MissedLab.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/5/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MissedItem.h"
#import "LabAlert.h"
#import "MTLJSONAdapter.h"

@interface MissedLab : MissedItem <MTLJSONSerializing>


@property (nonatomic, retain, readonly) LabAlert *labAlert;

@end
