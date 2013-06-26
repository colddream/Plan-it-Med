//
//  GeneralAlert.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/4/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Alert.h"
#import "MTLJSONAdapter.h"

@interface GeneralAlert : Alert <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSArray *dayType;
@property (nonatomic, retain, readonly) NSDate *time;

+ (void)createWithName:(NSString *)name dayType:(NSArray *)dayType time:(NSDate *)time withBlock:(void(^)(BOOL status, NSString *message, NSError *error))block;
- (void)updateWithBlock:(void(^)(BOOL status, NSString *message, NSError *error))block;
+ (void)deleteWithAlertId:(NSNumber *)alertId withBlock:(void(^)(BOOL status, NSString *message, NSError *error))block;

@end
