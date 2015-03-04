//
//  NSString+Additions.h
//  RecUtilities
//
//  Created by Rob Timpone on 7/7/14.
//  Copyright (c) 2014 RECSOLU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Additions)

/**
 Returns true if a string is nil or empty.  A string made up of whitespace only counts as being empty.
 @param aString
    The string to evaluate.
 @return
    A boolean indicating whether the string is nil or empty.
 */
+ (BOOL)stringIsNilOrEmpty: (NSString *)aString;

/**
 Creates a new formatted string allowing for route tokenization
 
 Effectivley the same as +[NString stringWithFormat:] but allows you to use formatting strings resembling the following:
 @"/events/:eventId/attendees/:attendeeId" instead of @"/events/%@/attendees/%@"
 The string substituations are still performed in the order they are given as format args, the tokenization is just a visual niceity.
 
 @param route The route string to format.
 @param ... A comma-separated list of arguments to substitute into format.
 @return A formated string to use as a route.
 */
+ (instancetype)stringWithRoute: (NSString *)route, ...;

@end
