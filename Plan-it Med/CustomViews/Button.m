//
//  Button.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/21/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "Button.h"
#import <QuartzCore/QuartzCore.h>

@implementation Button

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"initwithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"draw rect");
    // Drawing code
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [gradientLayer setFrame:self.frame];
    [self.layer addSublayer:gradientLayer];
}

@end
