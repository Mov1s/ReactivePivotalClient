//
//  NSArray+Additions.m
//  RecUtilities
//
//  Created by Ryan Popa on 3/4/15.
//  Copyright (c) 2015 RECSOLU. All rights reserved.
//

#import "NSArray+Additions.h"

@implementation NSArray (Additions)

//Map objects to a new array using a block
- (NSMutableArray *)mapObjectsUsingBlock: (id (^)(id obj, NSUInteger idx))block
{
    NSMutableArray *results = [NSMutableArray new];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [results addObject: block(obj, idx)];
    }];
    return results;
}

//Map objects to a new set using a block
- (NSMutableSet *)mapObjectsToSetUsingBlock: (id (^)(id obj, NSUInteger idx))block
{
    NSMutableSet *results = [NSMutableSet new];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [results addObject: block(obj, idx)];
    }];
    return results;
}

@end
