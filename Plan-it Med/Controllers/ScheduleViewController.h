//
//  ScheduleViewController.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/24/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"

@interface ScheduleViewController : UIViewController <CKCalendarDelegate>

@property (retain, nonatomic) CKCalendarView *calendarView;
@property (retain, nonatomic) UIView *listView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *calAndListSegmentedControl;
@property (weak, nonatomic) IBOutlet UIView *contentView;

- (IBAction)calAndListSegmentedControlValueChanged:(id)sender;
@end
