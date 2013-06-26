//
//  CDAppDelegate.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/24/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "CDAppDelegate.h"
#import "MTLValueTransformer.h"
#import "YISplashScreen.h"
#import "YISplashScreen+Migration.h" // optional
#import "YISplashScreenAnimation.h"
#import "Flurry.h"
#import "PlanAlert.h"
#import "ModelHelper.h"
#import "Team.h"
#import "Pager.h"
#import "Reachability.h"

@implementation CDAppDelegate


-(void)setUpLoader
{
    _loaderView = [[UIView alloc] initWithFrame:self.window.frame];
    _loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 227, 227)];
    NSArray* loadingArray=[[NSArray alloc] initWithObjects:
                           [UIImage imageNamed:@"loader1.png"],
                           [UIImage imageNamed:@"loader2.png"],
                           [UIImage imageNamed:@"loader3.png"],
                           [UIImage imageNamed:@"loader4.png"],
                           [UIImage imageNamed:@"loader5.png"],
                           [UIImage imageNamed:@"loader6.png"],
                           [UIImage imageNamed:@"loader7.png"],
                           [UIImage imageNamed:@"loader8.png"],
                           [UIImage imageNamed:@"loader9.png"],
                           [UIImage imageNamed:@"loader10.png"],
                           nil];
    _loadingImageView.animationImages=loadingArray;
    _loadingImageView.animationDuration=1.0;
    [_loaderView setBackgroundColor:[UIColor colorWithWhite:0 alpha:.77]];
    _loadingImageView.center=CGPointMake(_loaderView.bounds.size.width/2, _loaderView.bounds.size.height/2);
    [_loaderView addSubview:_loadingImageView];
}


-(void)appStartedLoading
{
    [_loadingImageView startAnimating];
    [self.window addSubview:_loaderView];
}


-(void)appStoppedLoading
{
    [_loaderView removeFromSuperview];
    [_loadingImageView stopAnimating];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSLog(@"launchOptions: %@",launchOptions);
    //Set fixed statusBarStyle (not change color depend on navigationBar color)
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque
                                                animated:NO];
    
    //Intializing Kiip
    Kiip *kiip = [[Kiip alloc] initWithAppKey:@"5f468cf229c1a3c96dd9ff9ef64eeb11" andSecret:@"68b657f0b56629dab9435c5a09bee810"];
    kiip.delegate = self;
    [Kiip setSharedInstance:kiip];

    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    //
//    [Flurry startSession:@"PQY2QG6B72GPXT6CYRQZ"];
//    
    [self setUpLoader];
//    
//    // show splash
//    [YISplashScreen show];
//
//    [YISplashScreen hideWithAnimationBlock:^(CALayer* splashLayer, CALayer* rootLayer) {
//
//        // splashLayer moves up
//        [CATransaction begin];
//        [CATransaction setAnimationDuration:0.7];
//        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//
//        splashLayer.position = CGPointMake(splashLayer.position.x, splashLayer.position.y-splashLayer.bounds.size.height);
//
//        [CATransaction commit];
//        
//    }];
//    
//    NSArray *dayType = @[@1,@2,@3,@4];
//    NSString *dayTypeString = [ModelHelper stringFromDayType:dayType];
//    NSLog(@"original dayType: %@",dayType);
//    NSLog(@"dayTypeString: %@",dayTypeString);
//    NSLog(@"new dayType: %@",[ModelHelper dayTypeFromString:dayTypeString]);
//    
//    NSDictionary *pagerDict = @{
//        @"totalRecords": @(100),
//        @"recordsPerPage": @(10),
//        @"recordsInPage": @(2)
//    };
//    NSDictionary *pagerDict2 = @{
//    @"totalRecords": @(200),
//    @"recordsPerPage": @(20),
//    @"recordsInPage": @(4)
//    };
//    
//    Pager *pager = [Pager modelWithDictionary:pagerDict error:nil];
//    
//    NSDictionary *teamDict = @{
//        @"ID": @1,
//        @"doctorId": @2,
//        @"doctorName": @"Thang",
//        @"phone": @"01673747979",
//        @"pager": pager,
//        @"email": @"thangdq.uit.edu@gmail.com"
//    };
//    
//    NSDictionary *JSONTeamDict = @{
//        @"teamId": @"1",
//        @"doctorId": @"2",
//        @"doctorName": @"Thang",
//        @"phone": @"01673747979",
//        @"pagers": @{
//            @"totalRecord": @"100",
//            @"itemPerPage": @"10",
//            @"itemInPage": @"2"
//        },
//        @"email": @"thangdq.uit.edu@gmail.com"
//    };
//    
//    Team *team = [Team modelWithDictionary:teamDict error:nil];
//    NSDictionary *JSONPager = [MTLJSONAdapter JSONDictionaryFromModel:pager];
//    NSDictionary *JSONTeam = [MTLJSONAdapter JSONDictionaryFromModel:team];
//    Team *team2 = [MTLJSONAdapter modelOfClass:Team.class fromJSONDictionary:JSONTeamDict error:nil];
//    
//    NSLog(@"pager: %@",pager);
//    NSLog(@"team: %@",team);
//    NSLog(@"JSONPager: %@",JSONPager);
//    NSLog(@"JSONTeam: %@",JSONTeam);
//    NSLog(@"team2: %@",team2);


    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) kiip:(Kiip *)kiip didReceiveContent:(NSString *)content quantity:(int)quantity transactionId:(NSString *)transactionId signature:(NSString *)signature
{
    NSLog(@"kiip didReceiveContrent: %@",content);
    NSLog(@"kiip quantity: %d",quantity);
    NSLog(@"kiip transactionId: %@",transactionId);
    NSLog(@"kiip signature: %@",signature);
}

- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability *reach = [note object];
    if (reach.isReachable) {
        NSLog(@"Common isReachable");
    } else {
        
        NSLog(@"Common isUnReachable");
    }
    
}

@end
