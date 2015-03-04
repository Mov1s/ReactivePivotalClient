//
//  PVRequestSignal.h
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/3/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import "RACSignal.h"

@interface PVRequestSignal : RACSignal

/** GET /me
 Returns information from the user's profile plus the list of projects to which the user has access.
 */
+ (RACSignal *)requestMe;

/** GET /my/notifications
 Return list of the notifications for the authenticated person. Response is sorted by notification created_at, most recent first.
 */
+ (RACSignal *)requestNotifications;

@end
