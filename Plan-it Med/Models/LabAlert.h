//
//  LabAlert.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/4/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Alert.h"
#import "Lab.h"
#import "MTLJSONAdapter.h"

@interface LabAlert : Alert <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSNumber *labId;
@property (nonatomic, retain, readonly) Lab *lab;
@property (nonatomic, retain, readonly) NSDate *dateTime;

@end
