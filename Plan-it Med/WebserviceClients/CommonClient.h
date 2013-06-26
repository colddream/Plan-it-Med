//
//  CommonClient.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/29/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "BaseHTTPClient.h"
@class User;

@interface CommonClient : BaseHTTPClient

+(CommonClient *)sharedClient;
+ (void)prepareWithUser:(User *)user;
+ (void)prepareWithBaseURL;
- (void)configureWithUser:(User *)user;

@end
