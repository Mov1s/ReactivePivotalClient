//
//  RPPlot.h
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface RPPlot : UIView

/** Trend line color */
@property (nonatomic, strong) IBInspectable UIColor *lineColor;

/** Width of the plot line */
@property (nonatomic) IBInspectable CGFloat lineWidth;

/** Fill color */
@property (nonatomic, strong) IBInspectable UIColor *fillColor;

/** Toggle the plot points on or off */
@property (nonatomic) IBInspectable BOOL plotPointVisible;

/** Radius of a plot point dot */
@property (nonatomic) IBInspectable CGFloat plotPointRadius;

/** Array of NSValue's containing CGPoints representing plot points */
@property (nonatomic, strong) NSArray *plotPoints;

/** Title of the plot */
@property (nonatomic, strong) IBInspectable NSString *plotTitle;

@end
