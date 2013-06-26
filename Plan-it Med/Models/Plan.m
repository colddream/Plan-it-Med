//
//  Plan.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/3/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Plan.h"
#import "ModelHelper.h"
#import "CommonClient.h"
#import "DoseData.h"

static NSString *createNewPlanPath = @"plan/create";
static NSString *planPath = @"plan/detail";

@implementation Plan


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"ID",
        @"medicationId": @"medicationId",
        @"medicationName": @"medicationName",
        @"medication": @"medication",
        @"doctorId": @"doctorId",
        @"dose": @"dose",
        @"choice": @"choice",
        @"route": @"route",
        @"startTime": @"startTime",
        @"dayRegimen": @"dayRegimen",
        @"timePerDay": @"timePerDay",
        @"doseData": @"doseData"
    };
}

+ (NSValueTransformer *)IDJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)medicationIdJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)doctorIdJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)dayRegimenJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)timePerDayJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)startTimeJSONTransformer {
    return [ModelHelper DateTimeJSONTransformer];
}

+ (NSValueTransformer *)medicationJSONTransformer {
    return [ModelHelper ClassJSONTransformer:Medication.class];
}

+ (NSValueTransformer *)doseDataJSONTransformer {
    return [ModelHelper ClassJSONTransformer:DoseData.class];
}

+ (void)createNewPlan:(Plan *)plan withBlock:(void(^)(BOOL status, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    [commonClient setParameterEncoding:AFJSONParameterEncoding];
    NSDictionary *JSONData = [MTLJSONAdapter JSONDictionaryFromModel:plan];
    
    [commonClient postPath:createNewPlanPath parameters:JSONData success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

+ (void)planOfID:(NSNumber *)ID withBlock:(void(^)(Plan *plan, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    NSString *planOfIDPath = [[NSString alloc] initWithFormat:@"%@?planId=%@", planPath, ID];
    [commonClient getPath:planOfIDPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        
        if (status) {
            NSDictionary *JSONPlan = [responseObject valueForKey:@"data"];
            Plan *plan = [MTLJSONAdapter modelOfClass:Plan.class fromJSONDictionary:JSONPlan error:nil];
            
            if (block) {
                block(plan, nil, nil);
            }
        } else {
            if (block) {
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

@end
