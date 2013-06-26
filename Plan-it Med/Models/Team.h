//
//  Team.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/10/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "Pager.h"
#import "MTLJSONAdapter.h"

@interface Team : MTLModel  <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSNumber *ID;
@property (nonatomic, retain, readonly) NSNumber *doctorId;
@property (nonatomic, retain, readonly) NSString *doctorName;
@property (nonatomic, retain, readonly) NSString *phone;
@property (nonatomic, retain, readonly) NSArray *pager;
@property (nonatomic, retain, readonly) NSString *email;

@end
