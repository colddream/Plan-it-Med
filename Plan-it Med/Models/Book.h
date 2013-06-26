//
//  Book.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/27/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Book : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSNumber *ID;
@property (nonatomic, retain, readonly) NSString *name;
@property (nonatomic, retain, readonly) NSString *summary;
@property (nonatomic, retain, readonly) NSString *category;
@property (nonatomic, retain, readonly) NSString *cover;
@property (nonatomic, retain, readonly) NSString *isStore;

+ (void)booksInPage:(NSUInteger)page withBlock:(void(^)(NSArray *books, NSString* message, NSError *error)) block;

@end
