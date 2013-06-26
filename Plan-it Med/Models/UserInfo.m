//
//  UserInfo.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/3/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "UserInfo.h"
#import "Schedule.h"
#import "ModelHelper.h"
#import "CommonClient.h"
#import "MissedAppointment.h"
#import "MissedLab.h"
#import "MissedPlan.h"
#import "MissedPearl.h"
#import "PlanAlert.h"
#import "Appointment.h"
#import "LabAlert.h"
#import "GeneralAlert.h"
#import "NowItem.h"
#import "Message.h"
#import "Pager.h"
#import "Quote.h"
#import "Pearl.h"
#import "Team.h"
#import "MTLJSONAdapter.h"

static NSString *missedItemsPath = @"item/missed";
static NSString *alertsPath = @"alert/get";
static NSString *nowItemsPath = @"item/now";
static NSString *unreadMessagesPath = @"message/unread";
static NSString *teamsPath = @"team/get";
static NSString *favoriteQuotesPath = @"quote/list?type=3";
static NSString *favoritePearlsPath = @"pearl/list?type=2";
static NSString *activitiesPath = @"user/activities";

@interface UserInfo()

@property (nonatomic, retain, readwrite) NSMutableDictionary *schedules;
@property (nonatomic, retain, readwrite) NSMutableArray *planAlerts;
@property (nonatomic, retain, readwrite) NSMutableArray *appointmentAlerts;
@property (nonatomic, retain, readwrite) NSMutableArray *labAlerts;
@property (nonatomic, retain, readwrite) NSMutableArray *generalAlerts;
@property (nonatomic, retain, readwrite) NSMutableArray *missedPlans;
@property (nonatomic, retain, readwrite) NSMutableArray *missedAppointments;
@property (nonatomic, retain, readwrite) NSMutableArray *missedLabs;
@property (nonatomic, retain, readwrite) NSMutableArray *missedPearls;
@property (nonatomic, retain, readwrite) NSMutableArray *unreadMessages;
@property (nonatomic, retain, readwrite) NSMutableArray *nowItems;
@property (nonatomic, retain, readwrite) NSMutableArray *teams;
@property (nonatomic, retain, readwrite) NSMutableArray *plans;
@property (nonatomic, retain, readwrite) NSMutableArray *favoriteQuotes;
@property (nonatomic, retain, readwrite) NSMutableArray *favoritePearls;
@property (nonatomic, retain, readwrite) NSNumber *reward;
@property (nonatomic, retain, readwrite) NSNumber *missedItemsCount;
@property (nonatomic, retain, readwrite) NSNumber *nowItemsCount;
@property (nonatomic, retain, readwrite) NSNumber *unreadMessagesCount;

@end

@implementation UserInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{};
}

- (id)init
{
    self = [super init];
    if (!self) {
        self.schedules = [[NSMutableDictionary alloc] init];
        self.planAlerts = [[NSMutableArray alloc] init];
        self.appointmentAlerts = [[NSMutableArray alloc] init];
        self.labAlerts = [[NSMutableArray alloc] init];
        self.generalAlerts = [[NSMutableArray alloc] init];
        self.missedPlans = [[NSMutableArray alloc] init];
        self.missedAppointments = [[NSMutableArray alloc] init];
        self.missedLabs = [[NSMutableArray alloc] init];
        self.missedPearls = [[NSMutableArray alloc] init];
        self.unreadMessages = [[NSMutableArray alloc] init];
        self.nowItems = [[NSMutableArray alloc] init];
        self.teams = [[NSMutableArray alloc] init];
        self.plans = [[NSMutableArray alloc] init];
        self.favoriteQuotes = [[NSMutableArray alloc] init];
        self.favoritePearls = [[NSMutableArray alloc] init];
        self.reward = @(0);
        self.missedItemsCount = @(0);
        self.nowItemsCount = @(0);
        self.unreadMessagesCount = @(0);
    }
    return self;
}

- (void)scheduleForDate:(NSDate *)date withBlock:(void (^)(Schedule *schedule, NSString *message, NSError *error))block
{
    NSString *dateString = [[ModelHelper dateFormatter] stringFromDate:date];
    
    if ([self.schedules.allKeys containsObject:dateString]) {
        if (block) {
            block([self.schedules objectForKey:dateString], nil, nil);
        }
    } else {
        [Schedule scheduleForDate:date withBlock:^(Schedule *schedule, NSString *message, NSError *error) {
            [self.schedules setValue:schedule forKey:dateString];
            if (block) {
                block(schedule, message, error);
            }
        }];
    }
}

- (void)alertsWithBlock:(void(^)(NSMutableArray *planAlerts, NSMutableArray *appointmentAlerts, NSMutableArray *labAlerts, NSMutableArray *generalAlerts, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    [commonClient getPath:alertsPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject objectForKey:@"status"] integerValue];
        if (status) {
            
            NSArray *JSONPlanAlerts = [responseObject valueForKeyPath:@"data.medication"];
            NSArray *JSONAppointmentAlerts = [responseObject valueForKeyPath:@"data.appointment"];
            NSArray *JSONLabAlerts = [responseObject valueForKeyPath:@"data.lab"];
            NSArray *JSONGeneralAlerts = [responseObject valueForKeyPath:@"data.personal"];
            [self.planAlerts removeAllObjects];
            [self.appointmentAlerts removeAllObjects];
            [self.labAlerts removeAllObjects];
            [self.generalAlerts removeAllObjects];
            
            for (NSDictionary *JSONPlanAlert in JSONPlanAlerts) {
                PlanAlert *planAlert = [MTLJSONAdapter modelOfClass:PlanAlert.class fromJSONDictionary:JSONPlanAlert error:nil];
                [self.planAlerts addObject:planAlert];
            }
            
            for (NSDictionary *JSONAppointmentAlert in JSONAppointmentAlerts) {
                AppointmentAlert *appointmentAlert = [MTLJSONAdapter modelOfClass:AppointmentAlert.class fromJSONDictionary:JSONAppointmentAlert error:nil];
                [self.appointmentAlerts addObject:appointmentAlert];
            }
            
            for (NSDictionary *JSONLabAlert in JSONLabAlerts) {
                LabAlert *labAlert = [MTLJSONAdapter modelOfClass:LabAlert.class fromJSONDictionary:JSONLabAlert error:nil];
                [self.labAlerts addObject:labAlert];
            }
            
            for (NSDictionary *JSONGeneralAlert in JSONGeneralAlerts) {
                GeneralAlert *generalAlert = [MTLJSONAdapter modelOfClass:GeneralAlert.class fromJSONDictionary:JSONGeneralAlert error:nil];
                [self.generalAlerts addObject:generalAlert];
            }
            if (block) {
                block(self.planAlerts, self.appointmentAlerts, self.labAlerts, self.generalAlerts, nil, nil);
            }
        } else {
            if (block) {
                NSString *message = [responseObject valueForKey:@"msg"];
                block(nil, nil, nil, nil, message, nil);
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, nil, nil, nil, nil, error);
        }
    }];
}

- (void)missedItemsWithBlock:(void(^)(NSMutableArray *missedPlans, NSMutableArray *missedAppointments, NSMutableArray *missedLabs, NSMutableArray *missedPearls, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    [commonClient getPath:missedItemsPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject objectForKey:@"status"] integerValue];
        if (status) {
            
            NSArray *JSONMissedPlans = [responseObject valueForKeyPath:@"data.medications"];
            NSArray *JSONMissedAppointments = [responseObject valueForKeyPath:@"data.appointments"];
            NSArray *JSONMissedLabs = [responseObject valueForKeyPath:@"data.labs"];
            NSArray *JSONMissedPearls = [responseObject valueForKeyPath:@"data.pearls"];
            [self.missedPlans removeAllObjects];
            [self.missedAppointments removeAllObjects];
            [self.missedLabs removeAllObjects];
            [self.missedPearls removeAllObjects];
            
            for (NSDictionary *JSONMissedPlan in JSONMissedPlans) {
                MissedPlan *missedPlan = [MTLJSONAdapter modelOfClass:MissedPlan.class fromJSONDictionary:JSONMissedPlan error:nil];
                [self.missedPlans addObject:missedPlan];
            }
            
            for (NSDictionary *JSONMissedAppointment in JSONMissedAppointments) {
                MissedAppointment *missedAppointment = [MTLJSONAdapter modelOfClass:MissedAppointment.class fromJSONDictionary:JSONMissedAppointment error:nil];
                [self.missedAppointments addObject:missedAppointment];
            }
            
            for (NSDictionary *JSONMissedLab in JSONMissedLabs) {
                MissedLab *missedLab = [MTLJSONAdapter modelOfClass:MissedLab.class fromJSONDictionary:JSONMissedLab error:nil];
                [self.missedLabs addObject:missedLab];
            }
            
            for (NSDictionary *JSONMissedPearl in JSONMissedPearls) {
                MissedPearl *missedPearl = [MTLJSONAdapter modelOfClass:MissedPearl.class fromJSONDictionary:JSONMissedPearl error:nil];
                [self.missedPearls addObject:missedPearl];
            }
            if (block) {
                block(self.missedPlans, self.missedAppointments, self.missedLabs, self.missedPearls, nil, nil);
            }
        } else {
            if (block) {
                NSString *message = [responseObject valueForKey:@"msg"];
                block(nil, nil, nil, nil, message, nil);
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, nil, nil, nil, nil, error);
        }
    }];
}

- (void)nowItemsWithBlock:(void(^)(NSArray *nowItems, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    [commonClient getPath:nowItemsPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        if (status) {
            NSArray *JSONNowItems = [responseObject valueForKey:@"data"];
            [self.nowItems removeAllObjects];
            for (NSDictionary *JSONNowItem in JSONNowItems) {
                NowItem *nowItem= [MTLJSONAdapter modelOfClass:NowItem.class fromJSONDictionary:JSONNowItem error:nil];
                [self.nowItems addObject:nowItem];
            }
            if (block) {
                block(self.nowItems, nil, nil);
            }
        } else {
            if (block) {
                NSString *message = [responseObject valueForKey:@"msg"];
                block(nil, message, nil);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, nil, error);
        }
    }];
}

- (void)unreadMessagesWithBlock:(void(^)(NSArray *unreadMessages, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    [commonClient getPath:unreadMessagesPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        
        if (status) {
            NSArray *JSONUnreadMessages = [responseObject valueForKey:@"data"];
            [self.unreadMessages removeAllObjects];
            
            for (NSDictionary *JSONUnreadMessage in JSONUnreadMessages) {
                Message *message= [MTLJSONAdapter modelOfClass:Message.class fromJSONDictionary:JSONUnreadMessage error:nil];
                [self.unreadMessages addObject:message];
            }
            if (block) {
                block(self.unreadMessages, nil, nil);
            }
        } else {
            if (block) {
                NSString *message = [responseObject valueForKey:@"msg"];
                block(nil, message, nil);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, nil, error);
        }
    }];
}

- (void)favoriteQuotesWithBlock:(void(^)(NSArray *favoriteQuotes, NSString *message, NSError *error))block
{
    [self favoriteQuotesInPage:1 withBlock:block];
}

- (void)favoritePearlsWithBlock:(void(^)(NSArray *favoritePearls, NSString *message, NSError *error))block
{
    [self favoritePearlsInPage:1 withBlock:block];
}

- (void)favoriteQuotesInPage:(NSUInteger)pageIndex withBlock:(void(^)(NSArray *favoriteQuotes, NSString *message, NSError *error))block
{
    NSString *favoriteQuotesInPagePath = [[NSString alloc] initWithFormat:@"%@&page=%d", favoriteQuotesPath, pageIndex];
    CommonClient *commonClient = [CommonClient sharedClient];
    [commonClient getPath:favoriteQuotesInPagePath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        if (status) {
            
            //Pager *pager = [responseObject valueForKeyPath:@"data.pager"];
            NSArray *JSONfavoriteQuotes = [responseObject valueForKey:@"data.data"];
            [self.favoriteQuotes removeAllObjects];
            
            for (NSDictionary *JSONfavoriteQuote in JSONfavoriteQuotes) {
                Quote *quote= [MTLJSONAdapter modelOfClass:Quote.class fromJSONDictionary:JSONfavoriteQuote error:nil];
                [self.favoriteQuotes addObject:quote];
            }
            if (block) {
                block(self.favoriteQuotes, nil, nil);
            }
        } else {
            if (block) {
                NSString *message = [responseObject valueForKey:@"msg"];
                block(nil, message, nil);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, nil, error);
        }
    }];
}

- (void)favoritePearlsInPage:(NSUInteger)pageIndex withBlock:(void(^)(NSArray *favoritePearls, NSString *message, NSError *error))block
{
    NSString *favoritePearlsInPagePath = [[NSString alloc] initWithFormat:@"%@&page=%d", favoritePearlsPath, pageIndex];
    CommonClient *commonClient = [CommonClient sharedClient];
    [commonClient getPath:favoritePearlsInPagePath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        if (status) {
            
            //Pager *pager = [responseObject valueForKeyPath:@"data.pager"];
            NSArray *JSONfavoritePearls = [responseObject valueForKey:@"data.data"];
            [self.favoritePearls removeAllObjects];
            for (NSDictionary *JSONfavoritePearl in JSONfavoritePearls) {
                Pearl *pearl= [MTLJSONAdapter modelOfClass:Pearl.class fromJSONDictionary:JSONfavoritePearl error:nil];
                [self.favoritePearls addObject:pearl];
            }
            if (block) {
                block(self.favoritePearls, nil, nil);
            }
        } else {
            if (block) {
                NSString *message = [responseObject valueForKey:@"msg"];
                block(nil, message, nil);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, nil, error);
        }
    }];
}

- (void)teamsWithBlock:(void(^)(NSArray *teams, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    [commonClient getPath:teamsPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        
        if (status) {
            NSArray *JSONTeams = [responseObject valueForKey:@"data"];
            [self.teams removeAllObjects];
            
            for (NSDictionary *JSONTeam in JSONTeams) {
                Team *team= [MTLJSONAdapter modelOfClass:Team.class fromJSONDictionary:JSONTeam error:nil];
                [self.teams addObject:team];
            }
            if (block) {
                block(self.teams, nil, nil);
            }
        } else {
            if (block) {
                NSString *message = [responseObject valueForKey:@"msg"];
                block(nil, message, nil);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, nil, error);
        }
    }];
}

- (void)activitiesWithBlock:(void(^)(NSNumber *reward, NSNumber *missedItemsCount, NSNumber *nowItemsCount, NSNumber *unreadMessagesCount, NSString *message, NSError *error))block
{
    CommonClient *commonClient = [CommonClient sharedClient];
    [commonClient getPath:activitiesPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL status = [[responseObject valueForKey:@"status"] integerValue];
        
        if (status) {
            NSString *JSONReward = [responseObject valueForKeyPath:@"data.rewards"];
            NSString *JSONMissedItemsCount = [responseObject valueForKeyPath:@"data.missed"];
            NSString *JSONNowItemsCount = [responseObject valueForKeyPath:@"data.now"];
            NSString *JSONUnreadMessagesCount = [responseObject valueForKeyPath:@"data.unreadMessage"];
            
            self.reward = @([JSONReward integerValue]);
            self.missedItemsCount = @([JSONMissedItemsCount integerValue]);
            self.nowItemsCount = @([JSONNowItemsCount integerValue]);
            self.unreadMessagesCount = @([JSONUnreadMessagesCount integerValue]);
            
            if (block) {
                block(self.reward, self.missedItemsCount, self.nowItemsCount, self.unreadMessagesCount, nil, nil);
            }
        } else {
            if (block) {
                NSString *message = [responseObject valueForKey:@"msg"];
                block(nil, nil, nil, nil, message, nil);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, nil, nil, nil, nil, error);
        }
    }];
}


@end
