//
//  DailyActivityView.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/18/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "DailyActivityView.h"

@implementation DailyActivityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //
        CGFloat colorTimelineViewHeight = 10.0f;
        CGFloat componentHeight = (frame.size.height - colorTimelineViewHeight)/4;
        UIView *colorTimelineView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width/2, 0, 1, colorTimelineViewHeight)];
        [colorTimelineView setBackgroundColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0]];
        
        //
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, colorTimelineViewHeight, frame.size.width, componentHeight)];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, componentHeight+colorTimelineViewHeight, frame.size.width, componentHeight)];
        self.thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, componentHeight*2+colorTimelineViewHeight, frame.size.width, componentHeight)];
        self.statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-componentHeight/2, componentHeight*3+colorTimelineViewHeight, componentHeight, componentHeight)];
        
        [self.timeLabel setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]];
        [self.nameLabel setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]];
        [self.thirdLabel setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]];
        [self.timeLabel setFont:[UIFont systemFontOfSize:14]];
        [self.nameLabel setFont:[UIFont systemFontOfSize:14]];
        [self.thirdLabel setFont:[UIFont systemFontOfSize:14]];
        self.timeLabel.text = @"9:25AM";
        self.nameLabel.text = @"VYVANSE";
        self.thirdLabel.text = @"200mg";
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.thirdLabel.textAlignment = NSTextAlignmentCenter;
        [self.statusImageView setImage:[UIImage imageNamed:@"icon.png"]];
        
        
        [self addSubview:colorTimelineView];
        [self addSubview:self.timeLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.thirdLabel];
        [self addSubview:self.statusImageView];
    }
    return self;
}

- (id)initWithOrigin:(CGPoint)origin
{
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, 105.0f, 100.0f)];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 105.0f, 20)];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 105.0f, 20)];
        self.thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 105.0f, 20)];
        self.statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 75, 105.0f, 13)];
        self.timeLabel.text = @"9:25AM";
        self.nameLabel.text = @"VYVANSE";
        self.thirdLabel.text = @"200mg";

        
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.thirdLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.timeLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.thirdLabel];
        [self addSubview:self.statusImageView];
    }
    return self;
}

 
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
