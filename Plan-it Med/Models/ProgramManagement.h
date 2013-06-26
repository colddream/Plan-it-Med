//
//  ProgramManagement.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/4/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "Pearl.h"
#import "Quote.h"
#import "Book.h"
#import "Information.h"


@interface ProgramManagement : NSObject

@property (nonatomic, readonly) Pearl *dailyPearl;
@property (nonatomic, readonly) NSArray *pearls;
@property (nonatomic, readonly) Quote *dailyQuote;
@property (nonatomic, readonly) NSArray *quotes;
@property (nonatomic, readonly) NSArray *books;
@property (nonatomic, readonly) NSArray *informations;

+ (ProgramManagement *)sharedProgramManagement;

- (void)dailyPearlWithBlock:(void(^)(Pearl *pearl, NSString *message, NSError *erro))block;
- (void)pearlsWithBlock:(void(^)(NSArray *pearls, NSString *message, NSError *erro))block;
- (void)dailyQuoteWithBlock:(void(^)(Quote *quote, NSString *message, NSError *erro))block;
- (void)quotesWithBlock:(void(^)(NSArray *quotes, NSString *message, NSError *erro))block;
- (void)booksWithBlock:(void(^)(Pearl *pearl, NSString *message, NSError *erro))block;
- (void)informationsWithBlock:(void(^)(Pearl *pearl, NSString *message, NSError *erro))block;

@end
