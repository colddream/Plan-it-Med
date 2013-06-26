//
//  CommonClient.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/29/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "CommonClient.h"
#import "AFJSONRequestOperation.h"
#import "User.h"


static NSString *defaultUserIdKey = @"X-PLANITV1-USERID";
static NSString *defaultAccessTokenKey = @"X-PLANITV1-ACCESS-TOKEN";
static NSString *BaseURLString;

@interface CommonClient()

@end

@implementation CommonClient


+ (CommonClient *)sharedClient {
    if (!BaseURLString) {
        NSLog(@"You have to prepare Base URL before");
        return nil;
    }
    static CommonClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"sharedClient init");       
        _sharedClient = [[CommonClient alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    });
    return _sharedClient;
}

+ (void)prepareWithBaseURL
{
    NSLog(@"prepare with BASE_URL");
    BaseURLString = BASE_URL;
    NSLog(@"BaseURLString: %@",BaseURLString);
}

+ (void)prepareWithUser:(User *)user
{
    if (!user.serverIP || [user.serverIP isEqualToString:@""]) {
        NSLog(@"prepare with BASE_URL");
        BaseURLString = BASE_URL;
        return;
    }
    NSLog(@"prepare with serverIP");
    BaseURLString = [[NSString alloc] initWithFormat:@"%@%@", user.serverIP, BASE_PATH];
    NSLog(@"BaseURLString: %@",BaseURLString);
}

- (void)configureWithUser:(User *)user
{
    NSLog(@"userId: %@",user.ID);
    NSLog(@"accessToken: %@",user.token);
    
    [self setDefaultHeader:defaultUserIdKey value:[user.ID stringValue]];
    [self setDefaultHeader:defaultAccessTokenKey value:user.token];
}

@end
