//
//  MissedPearl.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/5/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MissedPearl.h"
#import "ModelHelper.h"

@implementation MissedPearl

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"alertId": @"alertId",
        @"pearl": @"pearl",
        @"name": @"name",
        @"dateTime": @"dateTime"
    };
}

+ (NSValueTransformer *)pearlJSONTransformer {
    return [ModelHelper ClassJSONTransformer:Pearl.class];
}

- (void)updateReason:(NSString *)reason withBlock:(void(^)(BOOL status, NSString *message, NSError *error))block
{
    NSLog(@"do nothing");
}


@end
