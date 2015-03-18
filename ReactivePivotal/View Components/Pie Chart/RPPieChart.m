//
//  RPPieChart.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/13/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import "NSArray+Additions.h"
#import "RPPieChart.h"
#import "RPPieChartSection.h"
#import "UIColor+Additions.h"

@interface RPPieChart()

@property (nonatomic) CGFloat sectionStartAngle;

@property (nonatomic) CGFloat swatchStartPosition;

@property (nonatomic, strong) NSArray *chartColors;

@end

@implementation RPPieChart

- (instancetype)initWithCoder: (NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (!self) return nil;
    [self setup];
    return self;
}

- (instancetype)initWithFrame: (CGRect)frame
{
    self = [super initWithFrame: frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup
{
    //Chart defaults
    self.chartSections = [NSMutableArray new];
    self.chartWidth = 5;
    self.chartRadius = 30;
    self.chartCenterPoint = CGPointMake(40, 40);
    
    //Legend defaults
    self.legendVisible = YES;
    self.legendTopLeftPoint = CGPointMake(50, 10);
    self.legendFontSize = 15.0;
    self.legendSwatchRadius = 3;
    self.legendItemPadding = 5;
}

#pragma mark - Setters
- (void)setChartColorsFileName: (NSString *)chartColorsFileName
{
    _chartColorsFileName = chartColorsFileName;
    
    //Get the colors file
    NSString *colorsPlistPath = [[NSBundle mainBundle] pathForResource: self.chartColorsFileName ofType: @"plist"];
    NSArray *colorsPlist = [NSArray arrayWithContentsOfFile: colorsPlistPath];
    
    //Parse the colors
    self.chartColors = [colorsPlist mapObjectsUsingBlock: ^id(NSString *hexColor, NSUInteger idx) {
        return [UIColor colorWithHex: hexColor alpha: 1.0];
    }];
}

- (void)setChartSections: (NSArray *)chartSections
{
    _chartSections = chartSections;
    
    //Reset the chart drawing
    self.sectionStartAngle = M_PI / -2;
    
    //Reset the legend drawing
    self.swatchStartPosition = self.legendTopLeftPoint.y + self.legendSwatchRadius;
    
    //Create the pie sections
    for (RPPieChartSection *chartSection in self.chartSections)
        [self prepareSectionForRender: chartSection];
}

#pragma mark - IBDesignable Fugdgery
- (void)prepareForInterfaceBuilder
{
    self.chartSections = @[ [RPPieChartSection pieChartSectionWithPercentage: @.33 title: @"Approved"],
                            [RPPieChartSection pieChartSectionWithPercentage: @.4 title: @"Delivered"],
                            [RPPieChartSection pieChartSectionWithPercentage: @.19 title: @"Unstarted"],
                            [RPPieChartSection pieChartSectionWithPercentage: @.08 title: @"Rejected"]];
    
    self.chartColors = @[ [UIColor colorWithHex: @"#47A361" alpha: 1.0],
                          [UIColor colorWithHex: @"#D74B25" alpha: 1.0],
                          [UIColor colorWithHex: @"#E3C13C" alpha: 1.0],
                          [UIColor colorWithHex: @"#507BA3" alpha: 1.0] ];
}

#pragma mark - Drawing Helpers
- (void)drawRect: (CGRect)rect
{
    [super drawRect: rect];
    
    //Draw in context
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ref);
    
    //Draw sections
    [self.chartSections enumerateObjectsUsingBlock: ^(RPPieChartSection *obj, NSUInteger idx, BOOL *stop) {
        
        //Get the chart section color
        UIColor *sectionColor = obj.color ?: self.chartColors[idx % self.chartColors.count];
        [sectionColor setStroke];
        [sectionColor setFill];
        
        //Get section size
        CGFloat sectionEndAngle = (2 * M_PI * [obj.percentage floatValue]) + self.sectionStartAngle;
        
        //Construct section
        UIBezierPath *section = [UIBezierPath bezierPathWithArcCenter: CGPointMake(rect.size.width / 2, rect.size.height / 2) radius: self.chartRadius startAngle: self.sectionStartAngle endAngle: sectionEndAngle clockwise: YES];
        section.lineWidth = self.chartWidth;
        obj.sectionBezierPath = section;
        
        //Update the start point for the next section
        self.sectionStartAngle = sectionEndAngle;

        //Stroke the chart section
        [obj.sectionBezierPath stroke];
        
        //Add legend entry
        if (self.legendVisible)
        {
            NSString *legendTitle = [NSString stringWithFormat: @"%.0f%% %@", [obj.percentage floatValue] * 100, obj.title];
            [obj.swatchBezierPath fill];
            [legendTitle drawAtPoint: obj.legendTitlePoint withAttributes: @{ NSForegroundColorAttributeName : sectionColor,
                                                                            NSFontAttributeName            : [UIFont systemFontOfSize: self.legendFontSize] }];
        }
    }];
    
    CGContextRestoreGState(ref);
}

- (void)prepareSectionForRender: (RPPieChartSection *)chartSection
{
//    //Get section size
//    CGFloat sectionEndAngle = (2 * M_PI * [chartSection.percentage floatValue]) + self.sectionStartAngle;
//    
//    //Construct section
//    UIBezierPath *section = [UIBezierPath bezierPathWithArcCenter: self.chartCenterPoint radius: self.chartRadius startAngle: self.sectionStartAngle endAngle: sectionEndAngle clockwise: YES];
//    section.lineWidth = self.chartWidth;
//    chartSection.sectionBezierPath = section;
//    
//    //Update the start point for the next section
//    self.sectionStartAngle = sectionEndAngle;
    
    //Get the legend swatch point
    CGPoint swatchCenter = CGPointMake(self.legendTopLeftPoint.x + self.legendSwatchRadius,
                                       self.swatchStartPosition);
    
    //Construct the swatch
    chartSection.swatchBezierPath = [UIBezierPath bezierPathWithArcCenter: swatchCenter radius: self.legendSwatchRadius startAngle: 0 endAngle: 2 * M_PI clockwise: YES];

    //Draw legend title
    swatchCenter.x += self.legendSwatchRadius + 10;

    //Define attributes for the legend font
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize: self.legendFontSize] };
    swatchCenter.y -= [chartSection.title sizeWithAttributes: attributes].height / 2;
    chartSection.legendTitlePoint = swatchCenter;
    
    //Update the start point for the next swatch
    self.swatchStartPosition += (self.legendSwatchRadius * 2) + self.legendItemPadding;
}

@end
