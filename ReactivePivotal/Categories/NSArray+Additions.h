//
//  NSArray+Additions.h
//  RecUtilities
//
//  Created by Ryan Popa on 3/4/15.
//  Copyright (c) 2015 RECSOLU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Additions)

/** Map objects to a new array using a block
 @param block The mapping block to use
 @return A new mapped array of objects
 */
- (NSMutableArray *)mapObjectsUsingBlock: (id (^)(id obj, NSUInteger idx))block;

/** Map objects to a new set using a block
 @param block The mapping block to use
 @return A new mapped set of objects
 */
- (NSMutableSet *)mapObjectsToSetUsingBlock: (id (^)(id obj, NSUInteger idx))block;

@end
