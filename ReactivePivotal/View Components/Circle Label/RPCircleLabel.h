//
//  RPCircleLabel.h
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface RPCircleLabel : UILabel

/** The color to use for the text and the border */
@property (nonatomic, strong) IBInspectable UIColor *color;

/** The width of the circle border */
@property (nonatomic) IBInspectable CGFloat borderWidth;

@end
