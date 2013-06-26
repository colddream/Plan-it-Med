//
//  TodayViewController.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/17/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "TodayViewController.h"
#import "DailyActivityView.h"
#import <QuartzCore/QuartzCore.h>

@interface TodayViewController ()

@end

@implementation TodayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [gradientLayer setFrame:self.viewNowButton.frame];
    [self.viewNowButton.layer addSublayer:gradientLayer];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"width: %f, height: %f", self.view.bounds.size.width, self.view.bounds.size.height);
    NSLog(@"width: %f, height: %f", self.view.frame.size.width, self.view.frame.size.height);
    
    self.alertScrollView.contentSize = CGSizeMake(1050.0f, 76.0f);
    self.alertScrollView.showsHorizontalScrollIndicator = NO;
    
    NSMutableArray *dailyActivityViews = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i++) {
        DailyActivityView *dailyActivityView = [[DailyActivityView alloc] initWithFrame:CGRectMake(i*105.0f, 0, 105.0f, 76.0f)];
        //dailyActivityView.nameLabel.text = [@(i) stringValue];
        [dailyActivityViews addObject:dailyActivityView];
    }
    
    for (int i = 0; i < 10; i++) {
        [self.alertScrollView addSubview:[dailyActivityViews objectAtIndex:i]];
    }
    self.numberOfRewardPointsLabel.text = @"70";

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
