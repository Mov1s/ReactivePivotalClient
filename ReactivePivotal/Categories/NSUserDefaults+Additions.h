//
//  NSUserDefaults+Additions.h
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/3/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Additions)

/** Sets a Pivotal Api Token in user defaults to be retrieved later */
- (void)setPivotalApiToken: (NSString *)apiToken;

/** Gets a Pivotal Api Token from user defaults */
- (NSString *)pivotalApiToken;

@end
