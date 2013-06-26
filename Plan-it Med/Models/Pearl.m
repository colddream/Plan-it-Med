//
//  Pearl.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/27/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Pearl.h"
#import "CommonClient.h"
#import "ModelHelper.h"

static NSString *dailyPearlPath = @"pearls/list?type=1";
static NSString *pearlsPath = @"pearls/list?type=3";
static NSString *setFavoritePath = @"pearls/favorite";
static NSString *removeFavoritePath = @"pearls/removeFavorite";

@implementation Pearl


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"questionId": @"questionId",
        @"questionTitle": @"questionTitle",
        @"answers": @"answers",
        @"description": @"description",
        @"correctAnswerIndex": @"correctAnswer"
    };
}

+ (NSValueTransformer *)questionIdJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)correctAnswerIndexJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (void)dailyPearlWithBlock:(void(^)(Pearl *pearl, NSString *message, NSError *erro))block
{
    CommonClient *commonClient= [CommonClient sharedClient];
    NSString *dailyPearlInPagePath = [[NSString alloc] initWithFormat:@"%@&page=1",dailyPearlPath];
    [commonClient getPath:dailyPearlInPagePath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        if (block) {
            if (status) {
                NSArray *JSONPearls = [responseObject valueForKeyPath:@"data.data"];
                if (JSONPearls.count>=1) {
                    NSDictionary *JSONPearl = [JSONPearls objectAtIndex:0];
                    Pearl *pearl = [MTLJSONAdapter modelOfClass:Pearl.class fromJSONDictionary:JSONPearl error:nil];
                    block(pearl, nil, nil);
                }
            } else {
                NSString *message = [responseObject valueForKey:@"msg"];
                block(nil, message, nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, nil, error);
        }
    }];
}

+ (void)pearlsInPage:(NSUInteger)page withBlock:(void(^)(NSArray *pearls, NSString *message, NSError *erro))block
{
    CommonClient *commonClient= [CommonClient sharedClient];
    NSString *pearlsInPagePath = [[NSString alloc] initWithFormat:@"%@&page=%d", pearlsPath, page];
    [commonClient getPath:pearlsInPagePath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        if (block) {
            if (status) {
                NSArray *JSONPearls = [responseObject valueForKeyPath:@"data.data"];
                NSMutableArray *pearls = [[NSMutableArray alloc] init];
                for (NSDictionary *JSONPearl in JSONPearls) {
                    Pearl *pearl = [MTLJSONAdapter modelOfClass:Pearl.class fromJSONDictionary:JSONPearl error:nil];
                    [pearls addObject:pearl];
                }
                block(pearls, nil, nil);
            } else {
                NSString *message = [responseObject valueForKey:@"msg"];
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
        @"questionID":self.questionId
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
    NSString *removeFavoriteQuestionIDPath = [[NSString alloc] initWithFormat:@"%@?questionId=%@", removeFavoritePath, self.questionId];
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

- (void)setNumberAttempOfAnsers:(NSNumber *)number withBlock:(void(^)(BOOL status, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    NSDictionary *JSONData = @{
        @"questionID":self.questionId,
        @"attemptAnswer":number
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

@end
