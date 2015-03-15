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

#pragma mark - Line Configuration
/** Trend line color */
@property (nonatomic, strong) IBInspectable UIColor *lineColor;

/** Width of the plot line */
@property (nonatomic) IBInspectable CGFloat lineWidth;

#pragma mark - Fill Configuration
/** Fill color */
@property (nonatomic, strong) IBInspectable UIColor *fillColor;

#pragma mark - Plot Point Configuration
/** Toggle the plot points on or off */
@property (nonatomic) IBInspectable BOOL plotPointVisible;

/** Radius of a plot point dot */
@property (nonatomic) IBInspectable CGFloat plotPointRadius;

/** Array of NSValue's containing CGPoints representing plot points */
@property (nonatomic, strong) NSArray *plotPoints;

#pragma mark - Plot Range Configuration
/** The max Y value for the plot
 Defaults to 10 above the highest value given in self.plotPoints
 */
@property (nonatomic) IBInspectable CGFloat rangeMax;

/** The min Y value for the plot
 Defaults to 10 below the lowest value given in self.plotPoints
 */
@property (nonatomic) IBInspectable CGFloat rangeMin;

@end
