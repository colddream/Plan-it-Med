//
//  GeneralAlert.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/4/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "GeneralAlert.h"
#import "ModelHelper.h"
#import "CommonClient.h"

static NSString *createAlertPath = @"alert/create";
static NSString *deleteAlertPath= @"alert/delete";
static NSString *updateAlertPath= @"alert/update";

@interface GeneralAlert()

@property (nonatomic, retain, readwrite) NSNumber *type;

@end

@implementation GeneralAlert

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"alertId",
        @"active": @"active",
        @"name": @"name",
        @"type": @"type",
        @"dayType": @"dayType",
        @"time": @"time"
    };
}

- (id)init
{
    NSLog(@"LabAlert Init");
    self = [super init];
    if (self) {
        self.type = @(GeneralAlertType);
    }
    return self;
}

+ (NSValueTransformer *)timeJSONTransformer {
    return [ModelHelper TimeJSONTransformer];
}

+ (NSValueTransformer *)dayTypeJSONTransformer {
    return [ModelHelper NumbersJSONTransformer];
}

//dayType is array of enum WeekDayType: [Monday, TuesDay, ...]
+ (void)createWithName:(NSString *)name dayType:(NSArray *)dayType time:(NSDate *)time withBlock:(void(^)(BOOL status, NSString *message, NSError *error))block
{
    CommonClient *commonClient =[CommonClient sharedClient];
    [commonClient setParameterEncoding:AFJSONParameterEncoding];
    NSDictionary *JSONData = @{
        @"alertName" : name,
        @"dayType" : dayType,
        @"time" : [[ModelHelper timeFormatter] stringFromDate:time]
    };
    
    [commonClient postPath:createAlertPath parameters:JSONData success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (void)updateWithBlock:(void(^)(BOOL status, NSString *message, NSError *error))block
{
    CommonClient *commonClient =[CommonClient sharedClient];
    [commonClient setParameterEncoding:AFJSONParameterEncoding];
    NSDictionary *JSONData = @{
        @"alertId" : self.ID,
        @"alertName" : self.name,
        @"dayType" : self.dayType,
        @"time" : [[ModelHelper timeFormatter] stringFromDate:self.time]
    };
    
    [commonClient putPath:createAlertPath parameters:JSONData success:^(AFHTTPRequestOperation *operation, id responseObject) {
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



+ (void)deleteWithAlertId:(NSNumber *)alertId withBlock:(void(^)(BOOL status, NSString *message, NSError *error))block
{
    CommonClient *commonClient =[CommonClient sharedClient];
    [commonClient setParameterEncoding:AFJSONParameterEncoding];
    NSDictionary *JSONData = @{
        @"alertId" : alertId
    };
    
    [commonClient deletePath:deleteAlertPath parameters:JSONData success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
