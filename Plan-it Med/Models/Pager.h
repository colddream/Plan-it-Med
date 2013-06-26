//
//  Pager.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/5/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Pager : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSNumber *totalRecords;
@property (nonatomic, retain, readonly) NSNumber *recordsPerPage;
@property (nonatomic, retain, readonly) NSNumber *recordsInPage;

@end
