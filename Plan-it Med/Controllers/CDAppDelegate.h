//
//  CDAppDelegate.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/24/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KiipSDK/KiipSDK.h>

@interface CDAppDelegate : UIResponder <UIApplicationDelegate, KiipDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic) UIView* loaderView;
@property(nonatomic) UIImageView* loadingImageView;

-(void)appStartedLoading;
-(void)appStoppedLoading;

@end
