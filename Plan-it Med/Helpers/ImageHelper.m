//
//  ImageHelper.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/24/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "ImageHelper.h"

@interface ImageHelper()

@end

@implementation ImageHelper

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    if (size.width == 0.0 || size.height == 0.0) {
        NSLog(@"imageWithColor can't not passed height or width is equal 0, default = 1");
        size.width = 1.0;
        size.height = 1.0;
    }
    UIImage *image = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)backgroundImageWithColor:(UIColor *)color
{
    CGSize size = CGSizeMake(1.0, 1.0);
    UIImage *image = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)sharedNavigationBarImage
{
    static UIImage *_navigationBarImage = nil;
    NSLog(@"sharedNavigationBarImage");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"sharedNavigationBarImage dispatch_once");
        _navigationBarImage = [self backgroundImageWithColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0]];
    });
    
    return _navigationBarImage;
}

@end
