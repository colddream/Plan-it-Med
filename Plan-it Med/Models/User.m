//
//  User.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/24/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "User.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "MTLValueTransformer.h"
#import "UserClient.h"
#import "CommonClient.h"
#import "CDAppDelegate.h"
#import "ModelHelper.h"
#import "Flurry.h"

static NSString *loginPath = @"oauth";

@interface User()

@end

@implementation User

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"JSONKeyPathsByPropertyKey");
    return @{
        @"ID": @"userId",
        @"token": @"token",
        @"userInfo": @"userInfo"
    };
}

+ (NSValueTransformer *)IDJSONTransformer {
    return [ModelHelper NumberJSONTransformer];
}

+ (NSValueTransformer *)userInfoJSONTransformer {
    return [ModelHelper ClassJSONTransformer:UserInfo.class];
}

+ (void)loginWithUserName:(NSString *)userName password:(NSString *)password withBlock:(void (^)(User *user, NSString *message, NSError *error))block
{
    
    [Flurry logEvent:@"login"];
    UserClient *userClient = [UserClient userClient];
    [userClient setDefaultHeaderWithUser:userName password:password];
    CDAppDelegate *theApplication = (CDAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [theApplication appStartedLoading];
    NSLog(@"start login");
    NSLog(@"theApplication: %@",theApplication);
    [userClient getPath:loginPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (block) {
            
            BOOL status = [[responseObject valueForKey:@"status"] integerValue];
            NSLog(@"Login success");
            NSLog(@"status: %d",status);
            NSLog(@"responseObject: %@",responseObject);
            
            NSLog(@"have block1");
            if (status) {
                
                NSDictionary *data = [responseObject valueForKey:@"data"];
                User *user = [MTLJSONAdapter modelOfClass:User.class fromJSONDictionary:data error:nil];
                if (!user.ID || !user.token) {
                    
                    block(nil, nil, nil);
                    
                } else {
                    
                    block(user, nil, nil);
                    [CommonClient prepareWithBaseURL];
                    //[CommonClient prepareWithUser:user];
                    [[CommonClient sharedClient] configureWithUser:user];
                }
                
            } else {
                NSString *message = [responseObject valueForKey:@"msg"];
                block(nil, message, nil);
            }
            
        }
        
        NSLog(@"seccess login");
        [theApplication appStoppedLoading];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (block) {
            block(nil, nil, error);
            NSLog(@"have block2");
        }
        NSLog(@"fail login");
        [theApplication appStoppedLoading];
    }];
    
    NSLog(@"end login");
}





@end
