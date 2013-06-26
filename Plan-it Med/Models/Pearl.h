//
//  Pearl.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/27/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Pearl : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSString *questionId;
@property (nonatomic, retain, readonly) NSString *questionTitle;
@property (nonatomic, retain, readonly) NSArray *answers;
@property (nonatomic, retain, readonly) NSString *description;
@property (nonatomic, retain, readonly) NSNumber *correctAnswerIndex;

+ (void)dailyPearlWithBlock:(void(^)(Pearl *pearl, NSString *message, NSError *error))block;
+ (void)pearlsInPage:(NSUInteger)page withBlock:(void(^)(NSArray *pearls, NSString *message, NSError *erro))block;
- (void)setFavoriteWithBlock:(void(^)(BOOL status, NSString *message, NSError *error))block;
- (void)removeFavoriteWithBlock:(void(^)(BOOL status, NSString *message, NSError *error))block;
- (void)setNumberAttempOfAnsers:(NSNumber *)number withBlock:(void(^)(BOOL status, NSString *message, NSError *error))block;

@end
