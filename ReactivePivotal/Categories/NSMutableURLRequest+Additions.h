//
//  NSMutableURLRequest+Additions.h
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/3/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (Additions)

/** Creates and returns a URL request for a specified URL with default cache policy and timeout value.
 The created URL has an authentication header for PivotalTracker API if one has been set.
 The default cache policy is NSURLRequestUseProtocolCachePolicy and the default timeout interval is 60 seconds.
 
 @param url The URL for the new request.
 */
+ (instancetype)requestWithAuthenticatedPivotalURL: (NSURL *)url;

@end
