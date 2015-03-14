//
//  RPPieChart.h
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/13/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface RPPieChart : UIView

/** Sections to show on chart
 They will be shown in the order given
*/
@property (nonatomic, strong) NSArray *chartSections;

#pragma mark - Chart Style
@property (nonatomic) IBInspectable CGFloat chartRadius;

@property (nonatomic) IBInspectable CGFloat chartWidth;

@property (nonatomic, strong) IBInspectable NSString *chartColorsFileName;

@property (nonatomic) IBInspectable CGPoint chartCenterPoint;

#pragma mark - Legend Style
@property (nonatomic) IBInspectable BOOL legendVisible;

@property (nonatomic) IBInspectable CGPoint legendTopLeftPoint;

@property (nonatomic) IBInspectable CGFloat legendSwatchRadius;

@property (nonatomic) IBInspectable CGFloat legendFontSize;

@property (nonatomic) IBInspectable CGFloat legendItemPadding;

@end
