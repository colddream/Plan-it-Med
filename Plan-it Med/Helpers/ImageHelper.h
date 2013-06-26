//
//  ImageHelper.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/24/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageHelper : NSObject

+ (UIImage *)backgroundImageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
+ (UIImage *)sharedNavigationBarImage;
@end
