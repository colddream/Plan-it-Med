//
//  Pager.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/5/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Pager.h"
#import "ModelHelper.h"

@implementation Pager

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"totalRecords": @"totalRecord",
        @"recordsPerPage": @"itemPerPage",
        @"recordsInPage": @"itemInPage"
    };
}

+ (NSValueTransformer *)totalRecordsJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)recordsPerPageJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)recordsInPageJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

@end
