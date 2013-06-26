//
//  ScheduleViewController.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/24/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "ScheduleViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageHelper.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIColor *transparentColor = [UIColor colorWithWhite:1.0 alpha:0.0];
    self.calendarView = [[CKCalendarView alloc] initWithStartDay:startSunday];
    self.calendarView.delegate = self;
    
    self.calendarView.onlyShowCurrentMonth = NO;
    self.calendarView.adaptHeightToNumberOfWeeksInMonth = YES;
    
    [self.calendarView setBackgroundColor:transparentColor];
    [self.calendarView setTitleColor:[UIColor blackColor]];
    [self.calendarView setMonthButtonColor:[UIColor blackColor]];
    [self.calendarView setInnerBorderColor:[UIColor blueColor]];
     
    [self.calendarView setDayOfWeekBottomColor:transparentColor topColor:transparentColor];
    [self.calendarView setDayOfWeekTextColor:[UIColor blackColor]];
    
    
    self.listView = [[UIView alloc] init];
    [self.listView setBackgroundColor:[UIColor blueColor]];

    
}

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
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)loadView
{
    NSLog(@"loadView");
    [super loadView];
    [self customCalAndListSegmentedControl];
    [self.contentView addSubview:self.calendarView];
    [self.contentView addSubview:self.listView];
    [self addConstraintsOfCalendarViewIntoContentView];
    //[self addConstraintsOfListViewIntoContentView];
    [self bringCalendarViewToFront];
    NSLog(@"loadView end");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark custom methods
- (void)bringCalendarViewToFront
{
    [self.contentView bringSubviewToFront:self.calendarView];
}

- (void)bringListViewToFront
{
    [self.contentView bringSubviewToFront:self.listView];
}

- (void)addConstraintsOfCalendarViewIntoContentView
{
    self.calendarView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_calendarView]|" options:nil metrics:nil views:NSDictionaryOfVariableBindings(_calendarView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_calendarView]|" options:nil metrics:nil views:NSDictionaryOfVariableBindings(_calendarView)]];
}

- (void)addConstraintsOfListViewIntoContentView
{
    self.listView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_listView]|" options:nil metrics:nil views:NSDictionaryOfVariableBindings(_listView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_listView]|" options:nil metrics:nil views:NSDictionaryOfVariableBindings(_listView)]];
}

- (void)customCalAndListSegmentedControl
{
    //Set height
    CGFloat segmentedControlHeight = 35.0;
    //Set image for state of calAndListSegmentedControl
    UIImage *segmentedControlNormalImage = [ImageHelper imageWithColor:[UIColor grayColor] andSize:CGSizeMake(1, segmentedControlHeight)];
    UIImage *segmentedControlSelectedImage = [ImageHelper imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(1, segmentedControlHeight)];
    UIImage *dividerImage = [ImageHelper imageWithColor:[UIColor redColor] andSize:CGSizeMake(0.1, 0.1)];
    
    
    //Set layer for calAndListSegmentedControl
    CALayer * layer = [self.calAndListSegmentedControl layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:5.0]; //when radius is 0, the border is a rectangle
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0] CGColor]];
    
    [self.calAndListSegmentedControl setBackgroundImage:segmentedControlNormalImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.calAndListSegmentedControl setBackgroundImage:segmentedControlSelectedImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    NSDictionary *attributes = @{
                                 UITextAttributeTextColor : [UIColor blackColor],
                                 UITextAttributeFont : [UIFont fontWithName:@"ArialMT" size:16],
                                 UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0, 0.0)]
                                 };
    [self.calAndListSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [self.calAndListSegmentedControl setDividerImage:dividerImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
}


#pragma mark Interface builder action
- (IBAction)calAndListSegmentedControlValueChanged:(id)sender {
    
    if (self.calAndListSegmentedControl.selectedSegmentIndex == 0) {
        NSLog(@"calendar selected");
        [self bringCalendarViewToFront];
    } else if (self.calAndListSegmentedControl.selectedSegmentIndex == 1) {
        NSLog(@"list selected");
        [self bringListViewToFront];
    }
}

#pragma mark CKCalendarViewDelegate

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
    if ([calendar date:date isSameDayAsDate:[NSDate date]]) {
        
        dateItem.backgroundColor = [UIColor grayColor];
        dateItem.selectedBackgroundColor = [UIColor greenColor];
    } else {
        
        dateItem.backgroundColor = [UIColor whiteColor];
        dateItem.selectedBackgroundColor = [UIColor greenColor];
    }
    
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    NSLog(@"willSelectDate");
    return YES;
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    NSLog(@"didSelectDate");
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    NSLog(@"willChangeToMonth");
    return YES;
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
    NSLog(@"didLayoutInRect");
    NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
}


@end
