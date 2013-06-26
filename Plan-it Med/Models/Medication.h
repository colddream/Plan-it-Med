//
//  Medication.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/3/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Medication : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSNumber *ID;
@property (nonatomic, retain, readonly) NSString *name;
@property (nonatomic, retain, readonly) NSString *description;
@property (nonatomic, retain, readonly) UIImage *image;

+ (void)medicationsWithTerm:(NSString *)term InPage:(NSUInteger)page block:(void(^)(NSArray *medications, NSString *message, NSError *error))block;
+ (void)medicationOfID:(NSNumber *)ID withBlock:(void(^)(Medication *medication, NSString *message, NSError *error))block;

@end
