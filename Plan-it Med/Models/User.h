//
//  User.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/24/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "UserInfo.h"

@interface User : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain, readonly) NSNumber *ID;
@property (nonatomic, retain, readonly) NSString *firstName;
@property (nonatomic, retain, readonly) NSString *lastName;
@property (nonatomic, retain, readonly) NSString *email;
@property (nonatomic, retain, readonly) NSString *password;
@property (nonatomic, retain, readonly) NSString *token;
@property (nonatomic, retain, readonly) NSString *serverIP;
@property (nonatomic, retain, readonly) UserInfo *userInfo;

+ (void)loginWithUserName:(NSString *)userName password:(NSString *)password withBlock:(void (^)(User *user, NSString *message, NSError *error))block;
+ (void)createWithFirstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email password:(NSString *)password withBlock:(void (^)(User *user, NSString *message, NSError *error))block;

@end
