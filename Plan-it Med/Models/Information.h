//
//  Information.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/4/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Information : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSNumber *ID;
@property (nonatomic, retain, readonly) NSString *title;
@property (nonatomic, retain, readonly) NSURL *link;

@end
