//
//  NowItem.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/5/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "NowItem.h"
#import "ModelHelper.h"
#import "CommonClient.h"

static NSString *takeNowPath = @"medication/take";

@implementation NowItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"alertId": @"alertId",
        @"medicationId": @"medicationId",
        @"medicationName": @"medicationName",
        @"doseName": @"doseName"
    };
}

+ (NSValueTransformer *)alertIdJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)medicationIdJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

- (void)takeNowWithBlock:(void(^)(BOOL status, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    NSDictionary *JSONData = @{
        @"alertIds":@[self.alertId]
    };
    [commonClient setParameterEncoding:AFJSONParameterEncoding];
    [commonClient putPath:takeNowPath parameters:JSONData success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

+ (void)takeNows:(NSArray *)alertIds withBlock:(void(^)(BOOL status, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    NSDictionary *JSONData = @{
        @"alertIds":alertIds
    };
    [commonClient setParameterEncoding:AFJSONParameterEncoding];
    [commonClient putPath:takeNowPath parameters:JSONData success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
