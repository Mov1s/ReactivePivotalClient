//
//  RPPieChartSection.h
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/13/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface RPPieChartSection : NSObject

/** The color for the section, if this is not specified it will cycle the default colors for the chart */
@property (nonatomic, strong) UIColor *color;

/** The point to display the legend text at */
@property (nonatomic) CGPoint legendTitlePoint;

/** The percentage of space this section consumes in the pie chart */
@property (nonatomic, strong) NSNumber *percentage;

/** The bezier path that will be used to render the section */
@property (nonatomic, strong) UIBezierPath *sectionBezierPath;

/** The bezier path that will be used to render the legend swatched */
@property (nonatomic, strong) UIBezierPath *swatchBezierPath;

/** The title of this section, this will be shown in the legend */
@property (nonatomic, strong) NSString *title;

/** Construct a new section
 Creates a new pie chart section with the given percentage and title.
 
 @param percentage The percentage of the pie chart to consume
 @param title The title of the section. This will be shown in the legend
 */
+ (instancetype)pieChartSectionWithPercentage: (NSNumber *)percentage title: (NSString *)title;

@end
