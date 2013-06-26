//
//  Message.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/27/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Message.h"
#import "CommonClient.h"
#import "ModelHelper.h"

static NSString *setReadPath = @"message/read";

@interface Message()

@property (nonatomic, retain, readwrite) NSNumber *read;

@end

@implementation Message

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"messageId",
        @"senderId": @"senderId",
        @"senderName": @"senderName",
        @"receiverId": @"receiverId",
        @"receiverName": @"receiverName",
        @"title": @"messageTitle",
        @"content": @"messageContent",
        @"dateTime": @"dateTime",
        @"read": @"read"
    };
}

- (id)init
{
    self = [super init];
    if (self) {
        self.read = @0;
    }
    return self;
}

+ (NSValueTransformer *)IDJSONTransformer {
    
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)senderIdJSONTransformer {
    
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)receiverIdJSONTransformer {
    
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)readJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)dateTimeJSONTransformer {
    return [ModelHelper DateTimeJSONTransformer];
}

- (void)setReadWithBlock:(void(^)(BOOL status, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    NSDictionary *JSONData = @{
        @"messageId":self.ID
    };
    
    [commonClient setParameterEncoding:AFJSONParameterEncoding];
    [commonClient putPath:setReadPath parameters:JSONData success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
