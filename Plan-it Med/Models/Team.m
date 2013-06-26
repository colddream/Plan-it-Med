//
//  Team.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/10/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Team.h"
#import "ModelHelper.h"

@implementation Team

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"teamId",
        @"doctorId": @"doctorId",
        @"doctorName": @"doctorName",
        @"phone": @"phone",
        @"pager": @"pager",
        @"email": @"email"
    };
}


+ (NSValueTransformer *)IDJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)doctorIdJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)pagerJSONTransformer {
    return [ModelHelper ClassJSONTransformer:Pager.class];
}

@end
