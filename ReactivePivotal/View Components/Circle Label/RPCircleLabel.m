//
//  RPCircleLabel.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import "RPCircleLabel.h"

@implementation RPCircleLabel

#pragma mark - Setters

//The width of the circle border
- (void)setBorderWidth: (CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

//The color to use for the text and the border
- (void)setColor: (UIColor *)color
{
    _color = color;
    
    //Set the border color
    self.layer.borderColor = color.CGColor;
    
    //Set the text color
    self.textColor = color;
}

#pragma mark - Layout Overrides

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //Set the border radius
    self.layer.cornerRadius = self.bounds.size.width / 2;
}

@end
