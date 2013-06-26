//
//  Medication.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/3/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Medication.h"
#import "MTLValueTransformer.h"
#import "CommonClient.h"
#import "ModelHelper.h"

static NSString *medicationsPath = @"medication/list";
static NSString *medicationPath = @"medication/detail";

@implementation Medication

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"medicationId",
        @"name": @"name",
        @"description": @"description",
        @"image": @"image"
    };
}


+ (NSValueTransformer *)IDJSONTransformer {
    
    return [ModelHelper NumberJSONTransformer];
}

//term = @"all": get all medications
//term != @"all": get medications Contain term
+ (void)medicationsWithTerm:(NSString *)term InPage:(NSUInteger)page block:(void(^)(NSArray *medications, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    NSString *medicationsWithTermAndPagePath = [[NSString alloc] initWithFormat:@"%@?term=%@&page=%d", medicationsPath, term, page];
    [commonClient getPath:medicationsWithTermAndPagePath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        
        if (status) {
            NSArray *JSONMedications = [responseObject valueForKeyPath:@"data.data"];
            NSMutableArray *medications = [[NSMutableArray alloc] init];
            
            for (NSDictionary *JSONMedication in JSONMedications) {
                Medication *medication= [MTLJSONAdapter modelOfClass:Medication.class fromJSONDictionary:JSONMedication error:nil];
                [medications addObject:medication];
            }
            if (block) {
                block(medications, nil, nil);
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

+ (void)medicationOfID:(NSNumber *)ID withBlock:(void(^)(Medication *medication, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    NSString *medicationOfIDPath = [[NSString alloc] initWithFormat:@"%@?medicationId=%@", medicationPath, ID];
    [commonClient getPath:medicationOfIDPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        
        if (status) {
            NSDictionary *JSONMedication = [responseObject valueForKey:@"data"];
            Medication *medication = [MTLJSONAdapter modelOfClass:Medication.class fromJSONDictionary:JSONMedication error:nil];
            
            if (block) {
                block(medication, nil, nil);
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
