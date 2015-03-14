//
//  UIColor+Additions.h
//  RecUtilities
//
//  Created by Ryan Popa on 11/13/14.
//  Copyright (c) 2014 RECSOLU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

/** Create a color from 8bit RGB values
 Each color value is provided as a number out of 255. Red would be represented as [UIColor colorWith8BitRed: 255 green: 0 blue: 0 alpha: 1]
 
 @param red The 8 bit red value
 @param green The 8 bit green value
 @param blue The 8 bit blue value
 @param alpha The alpha value as a decimal, 1 is fully opaque, 0 is fully translucent
 
 @return A color
 */
+ (UIColor *)colorWith8BitRed: (NSInteger)red green: (NSInteger)green blue: (NSInteger)blue alpha: (CGFloat)alpha;

/** Create a color from a hex string value
 Input should be in the format #000000. Red would be represented as [UIColor colorWithHex: @"#FF0000 alpha: 1]
 
 @param hex The hex color value, including the leading '#'
 @param alpha The alpha value as a decimal, 1 is fully opaque, 0 is fully translucent
 
 @return A color
 */
+ (UIColor *)colorWithHex: (NSString *)hex alpha: (CGFloat)alpha;

@end
