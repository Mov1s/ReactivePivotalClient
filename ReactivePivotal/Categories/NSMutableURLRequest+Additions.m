//
//  NSMutableURLRequest+Additions.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/3/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import "NSMutableURLRequest+Additions.h"
#import "NSUserDefaults+Additions.h"

@implementation NSMutableURLRequest (Additions)

+ (instancetype)requestWithAuthenticatedPivotalURL: (NSURL *)url
{
    //Get the saved token
    NSString *apiToken = [[NSUserDefaults standardUserDefaults] pivotalApiToken];
    
    //Create the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url];
    if (apiToken) [request setValue: apiToken forHTTPHeaderField: @"X-TrackerToken"];
    return request;
}

@end
