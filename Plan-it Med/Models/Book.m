//
//  Book.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/27/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Book.h"
#import "MTLValueTransformer.h"
#import "CommonClient.h"
#import "ModelHelper.h"

static NSString* booksPath = @"book/list";

@implementation Book

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"bookId",
        @"name": @"name",
        @"summary": @"summary",
        @"category": @"category",
        @"cover": @"cover",
        @"isStore": @"isStore"
    };
}

+ (NSValueTransformer *)IDJSONTransformer {
    
    return [ModelHelper NumberJSONTransformer];
}

+ (void)booksInPage:(NSUInteger)page withBlock:(void(^)(NSArray *books, NSString* message, NSError *error)) block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    NSString *booksInPagePath = [[NSString alloc] initWithFormat:@"%@?page=%d", booksPath, page];
    [commonClient getPath:booksInPagePath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        if (status) {
            NSArray *JSONBooks = [responseObject valueForKeyPath:@"data.data"];
            NSMutableArray *books = [[NSMutableArray alloc] init];
            for (NSDictionary *JSONBook in JSONBooks)
            {
                Book *book = [MTLJSONAdapter modelOfClass:Book.class fromJSONDictionary:JSONBook error:nil];
                [books addObject:book];
            }
            if (block) {
                block(books, nil, nil);
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

@end
