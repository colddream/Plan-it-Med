//
//  Quote.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/27/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Quote.h"
#import "ModelHelper.h"
#import "CommonClient.h"

static NSString *dailyQuotePath = @"quote/list?type=1";
static NSString *quotesPath = @"quote/list?type=2";
static NSString *setFavoritePath = @"quote/favorite";
static NSString *removeFavoritePath = @"quote/removeFavorite";

@implementation Quote

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"quoteId",
        @"content": @"quoteContent",
        @"author": @"quoteAuthor",
        @"dateTime": @"quoteDate"
    };
}

+ (NSValueTransformer *)IDJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)dateTimeJSONTransformer {
    return [ModelHelper DateTimeJSONTransformer];
}

+ (void)dailyQuoteWithBlock:(void(^)(Quote *quote, NSString *message, NSError *erro))block
{
    CommonClient *commonClient= [CommonClient sharedClient];
    NSString *dailyQuoteInPagePath = [[NSString alloc] initWithFormat:@"%@&page=1",dailyQuotePath];
    [commonClient getPath:dailyQuoteInPagePath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        if (status) {
            NSArray *JSONQuotes = [responseObject valueForKeyPath:@"data.data"];
            if (JSONQuotes.count>=1) {
                NSDictionary *JSONQuote = [JSONQuotes objectAtIndex:0];
                Quote *quote = [MTLJSONAdapter modelOfClass:Quote.class fromJSONDictionary:JSONQuote error:nil];
                if (block) {
                    block(quote, nil, nil);
                }
            }
        } else {
            NSString *message = [responseObject valueForKey:@"msg"];
            block(nil, message, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            if (block) {
                block(nil, nil, error);
            }
        }
    }];
}

+ (void)quotesInPage:(NSUInteger)page withBlock:(void(^)(NSArray *quotes, NSString *message, NSError *erro))block
{
    CommonClient *commonClient= [CommonClient sharedClient];
    NSString *quotesInPagePath = [[NSString alloc] initWithFormat:@"%@&page=%d", quotesPath, page];
    [commonClient getPath:quotesInPagePath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        if (status) {
            NSArray *JSONQuotes = [responseObject valueForKeyPath:@"data.data"];
            NSMutableArray *quotes = [[NSMutableArray alloc] init];
            for (NSDictionary *JSONQuote in JSONQuotes) {
                Quote *quote = [MTLJSONAdapter modelOfClass:Quote.class fromJSONDictionary:JSONQuote error:nil];
                [quotes addObject:quote];
            }
            if (block) {
                block(quotes, nil, nil);
            }
        } else {
            NSString *message = [responseObject valueForKey:@"msg"];
            if (block) {
                block(nil, message, nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, nil, error);
        }
    }];
}

- (void)setFavoriteWithBlock:(void(^)(BOOL status, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    NSDictionary *JSONData = @{
        @"quoteId":self.ID
    };
    [commonClient setParameterEncoding:AFJSONParameterEncoding];
    [commonClient postPath:setFavoritePath parameters:JSONData success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        NSString *message = [responseObject valueForKey:@"msg"];
        if (block) {
            block(status, message, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(0, nil, error);
        }
    }];
}

- (void)removeFavoriteWithBlock:(void(^)(BOOL status, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    NSString *removeFavoriteQuestionIDPath = [[NSString alloc] initWithFormat:@"%@?quoteId=%@", removeFavoritePath, self.ID];
    [commonClient deletePath:removeFavoriteQuestionIDPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        NSString *message = [responseObject valueForKey:@"msg"];
        if (block) {
            block(status, message, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(0, nil, error);
        }
    }];
}

@end
