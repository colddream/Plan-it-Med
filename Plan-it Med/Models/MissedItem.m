//
//  MissedItem.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/5/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MissedItem.h"
#import "ModelHelper.h"
#import "CommonClient.h"

static NSString *updateReasonPath = @"alert/updateReason";

@interface MissedItem()

@property (nonatomic, retain, readwrite) NSString *alertType;

@end

@implementation MissedItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"alertId": @"alertId",
        @"name": @"name",
        @"dateTime": @"dateTime",
        @"alertType": @"alertType"
    };
}

+ (NSValueTransformer *)alertIdeJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)dateTimeJSONTransformer {
    return [ModelHelper DateTimeJSONTransformer];
}

- (void)updateReason:(NSString *)reason withBlock:(void(^)(BOOL status, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    [commonClient setParameterEncoding:AFJSONParameterEncoding];
    NSDictionary *JSONData = @{
        @"alertId": self.alertId,
        @"alertType": self.alertType,
        @"reason": reason
    };
    
    [commonClient putPath:updateReasonPath parameters:JSONData success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
