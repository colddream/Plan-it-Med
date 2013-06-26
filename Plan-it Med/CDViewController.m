//
//  CDViewController.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/24/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "CDViewController.h"
#import "Reachability.h"
#import "User.h"

@interface CDViewController ()

@end

@implementation CDViewController

- (void)viewDidLoad
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    Reachability *reach = [Reachability reachabilityWithHostname:BASE_HOSTNAME];
    
    reach.reachableBlock = ^(Reachability *reach) {
        NSLog(@"block: reachable");
    };
    
    reach.unreachableBlock = ^(Reachability *reach) {
        NSLog(@"block: unreachale");
    };
    
    [reach startNotifier];
    
    if (reach.isReachable) {
        NSLog(@"hostname %@ is reachable",BASE_HOSTNAME);
        User *userLogin = nil;
        [User userWithUserName:@"thang" password:@"123456" withBlock:^(User *user, NSString *message, NSError *error) {
            userLogin = user;
        }];
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability *reach = [note object];
    if (reach.isReachable) {
        NSLog(@"isReachable");
    } else {
        
        NSLog(@"isUnReachable");
    }
    
}

@end
