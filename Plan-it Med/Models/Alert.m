//
//  Alert.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/4/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Alert.h"
#import "ModelHelper.h"
#import "CommonClient.h"

static NSString *setNotificationPath = @"alert/setStatus";

@interface Alert()

@property (nonatomic, retain, readwrite) NSNumber *type;

@end

@implementation Alert

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"alertId",
        @"active": @"active",
        @"name": @"name",
        @"type": @"type"
    };
}

+ (NSValueTransformer *)IDJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)activeJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)typeJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

- (void)setNotification:(BOOL)isNotifiable withBlock:(void(^)(BOOL status, NSString *message, NSError *error))block
{
    CommonClient *commonClient =[CommonClient sharedClient];
    [commonClient setParameterEncoding:AFJSONParameterEncoding];
    NSDictionary *JSONData = @{
        @"alertId" : self.ID,
        @"alertType" : self.type,
        @"setNotification" : @(isNotifiable)
    };
    
    [commonClient putPath:setNotificationPath parameters:JSONData success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
