//
//  UserClient.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/29/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "UserClient.h"
#import "AFJSONRequestOperation.h"

static NSString *defaultUserKey = @"X-PLANITV1-EMAIL";
static NSString *defaultPasswordKey = @"X-PLANITV1-PASSWORD";

@implementation UserClient


+ (UserClient *)userClient
{
    UserClient *_userClient = nil;
    _userClient = [[UserClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    return _userClient;
}

- (void)setDefaultHeaderWithUser:(NSString *)user password:(NSString *)password
{
    [self setDefaultHeader:defaultUserKey value:user];
    [self setDefaultHeader:defaultPasswordKey value:password];
}

@end
