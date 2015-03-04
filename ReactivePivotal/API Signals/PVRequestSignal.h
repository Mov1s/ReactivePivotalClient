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
 Returns information from the user's profile plus the list of projects to which the user has access
 */
+ (RACSignal *)requestMe;

@end
