//
//  NSString+Additions.m
//  RecUtilities
//
//  Created by Rob Timpone on 7/7/14.
//  Copyright (c) 2014 RECSOLU. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

//Returns true if a string is nil or empty.  A string made up of whitespace only counts as being empty.
+ (BOOL)stringIsNilOrEmpty: (NSString *)aString
{
    NSArray* words = [aString componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
    NSString* nospacestring = [words componentsJoinedByString: @""];
    return !(nospacestring && nospacestring.length);
}

//Creates a new formatted string allowing for route tokenization
+ (instancetype)stringWithRoute: (NSString *)route, ...
{
    //Construct a regex for pulling out route patterns
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: @":\\w+" options: NSRegularExpressionCaseInsensitive error: &error];
    if (error) return nil;
    
    //Replace all route tokens with formatting tokens "%@"
    NSMutableString *formattedRoute = [route mutableCopy];
    [regex replaceMatchesInString: formattedRoute options: NSMatchingReportCompletion range: NSMakeRange(0, [route length]) withTemplate: @"%@"];
    
    //Return a newly formatted string
    va_list va;
    va_start(va, route);
    NSString *string = [[NSString alloc] initWithFormat: formattedRoute arguments: va];
    va_end(va);
    
    return string;
}

@end
