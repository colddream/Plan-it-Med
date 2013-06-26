//
//  TodayViewController.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/17/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *alertScrollView;
@property (weak, nonatomic) IBOutlet UILabel *numberOfNewNotificationsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfRewardPointsLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewNowButton;
@property (weak, nonatomic) IBOutlet UILabel *DayOfWeekLabel;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;

@end
