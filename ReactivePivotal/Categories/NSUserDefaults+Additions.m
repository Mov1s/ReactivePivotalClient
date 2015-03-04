//
//  NSUserDefaults+Additions.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/3/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import "NSUserDefaults+Additions.h"

static NSString * const kPivotalApiTokenKey = @"kPivotalApiTokenKey";

@implementation NSUserDefaults (Additions)

//Sets a Pivotal Api Token in user defaults to be retrieved later
- (void)setPivotalApiToken: (NSString *)apiToken
{
    [self setValue: apiToken forKey: kPivotalApiTokenKey];
}

//Gets a Pivotal Api Token from user defaults
- (NSString *)pivotalApiToken
{
    return [self valueForKey: kPivotalApiTokenKey];
}

@end
