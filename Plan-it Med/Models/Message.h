//
//  Message.h
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/27/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Message : MTLModel <MTLJSONSerializing>


@property (nonatomic, retain, readonly) NSNumber *ID;
@property (nonatomic, retain, readonly) NSNumber *senderId;
@property (nonatomic, retain, readonly) NSString *senderName;
@property (nonatomic, retain, readonly) NSNumber *receiverId;
@property (nonatomic, retain, readonly) NSString *receiverName;
@property (nonatomic, retain, readonly) NSString *title;
@property (nonatomic, retain, readonly) NSString *content;
@property (nonatomic, retain, readonly) NSDate *dateTime;
@property (nonatomic, retain, readonly) NSNumber *read;

- (void)setReadWithBlock:(void(^)(BOOL status, NSString *message, NSError *error))block;

@end
