//
//  Quote.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/27/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Quote : MTLModel <MTLJSONSerializing>


@property (nonatomic, retain, readonly) NSNumber *ID;
@property (nonatomic, retain, readonly) NSString *content;
@property (nonatomic, retain, readonly) NSString *author;
@property (nonatomic, retain, readonly) NSDate *dateTime;

+ (void)dailyQuoteWithBlock:(void(^)(Quote *quote, NSString *message, NSError *erro))block;
+ (void)quotesInPage:(NSUInteger)page withBlock:(void(^)(NSArray *quotes, NSString *message, NSError *erro))block;
- (void)setFavoriteWithBlock:(void(^)(BOOL status, NSString *message, NSError *error))block;
- (void)removeFavoriteWithBlock:(void(^)(BOOL status, NSString *message, NSError *error))block;

@end
