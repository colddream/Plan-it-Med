//
//  Information.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/4/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Information.h"
#import "ModelHelper.h"
#import "CommonClient.h"

static NSString *informationsPath = @"information/get";

@implementation Information

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"pdfId",
        @"title": @"title",
        @"link": @"link"
    };
}

+ (NSValueTransformer *)IDJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)linkJSONTransformer {
    return [ModelHelper URLJSONTransformer];
}


+ (void)informationsWithBlock:(void(^)(NSArray *informations, NSString *message, NSError *error))block
{
    CommonClient *commonClient= [CommonClient sharedClient];
    [commonClient getPath:informationsPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        if (status) {
            NSArray *JSONInformations = [responseObject valueForKeyPath:@"data"];
            NSMutableArray *informations = [[NSMutableArray alloc] init];
            for (NSDictionary *JSONInformation in JSONInformations) {
                Information *information = [MTLJSONAdapter modelOfClass:Information.class fromJSONDictionary:JSONInformation error:nil];
                [informations addObject:information];
            }
            if (block) {
                block(informations, nil, nil);
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
