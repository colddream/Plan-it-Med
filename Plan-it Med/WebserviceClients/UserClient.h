//
//  UserClient.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/29/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "BaseHTTPClient.h"

@interface UserClient : BaseHTTPClient

+ (UserClient *)userClient;
- (void)setDefaultHeaderWithUser:(NSString *)user password:(NSString *)password;
@end
