//
//  NotificationsViewModel.h
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationsViewModel : NSObject

/** The notifcations for the logged in user */
@property (nonatomic, strong) NSArray *notifications;

@end
