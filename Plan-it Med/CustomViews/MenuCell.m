//
//  MenuCell.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/14/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithFrame:(CGRect)aRect
{
    self = [super initWithFrame:aRect];
    NSLog(@"initWithFrame");
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    
}

- (void)layoutSubviews
{
    
    [self setTranslatesAutoresizingMaskIntoConstraints:YES];
    [super layoutSubviews];
    // The framebuffer will be re-created at the beginning of the next setFramebuffer method call.
    //NSLog(@"layoutSubviews");
}


@end
