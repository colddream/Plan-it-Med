//
//  DailyActivityView.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/18/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyActivityView : UIView

@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UILabel *nameLabel; //Medication Name or Appointment Name, Lab Name
@property (nonatomic, retain) UILabel *thirdLabel; //dosage of medication, or name of doctor...
@property (nonatomic, retain) UIImageView *statusImageView;

- (id)initWithOrigin:(CGPoint)origin;

@end
