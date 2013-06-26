//
//  ProgramManagement.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/4/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "ProgramManagement.h"

@implementation ProgramManagement


+ (ProgramManagement *)sharedProgramManagement
{
    static ProgramManagement *_sharedProgramManagement = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedProgramManagement = [[ProgramManagement alloc] init];
    });
    
    return _sharedProgramManagement;
}

@end
