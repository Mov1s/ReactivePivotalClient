//
//  NotificationsViewModel.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NotificationsViewModel.h"
#import "PVRequestSignal.h"

@implementation NotificationsViewModel

- (instancetype)init
{
    //Initialize
    self = [super init];
    if (!self) return nil;
    
    //Request notifications datasource
    @weakify(self);
    [[PVRequestSignal requestNotifications]
    
        //Executed when notifcations are returned from the API
        //Sets the datasource
        subscribeNext: ^(NSArray *x) {
            @strongify(self);
            self.notifications = x;
        }
     
        //Executed when there was an error with the request
        //Clears the datasource
        error: ^(NSError *error) {
            @strongify(self);
            self.notifications = @[];
        }];
    
    return self;
}

@end
