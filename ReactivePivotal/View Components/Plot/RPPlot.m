//
//  RPPlot.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import "RPPlot.h"

@interface RPPlot()

@property (nonatomic, strong) UIBezierPath *backgroundBezierPath;

@property (nonatomic, strong) UIBezierPath *trendBezierPath;

@property (nonatomic, strong) NSMutableSet *plotCircles;

@end

@implementation RPPlot

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
    self.plotPointVisible = YES;
    self.plotPointRadius = 3;
    self.lineWidth = 2;
}

#pragma mark - Setters
- (void)setPlotPoints: (NSArray *)plotPoints
{
    _plotPoints = plotPoints;
    [self setNeedsDisplay];
}

- (void)setPlotTitle: (NSString *)plotTitle
{
    _plotTitle = plotTitle;
}

#pragma mark - IBDesignable Fugdgery
- (void)prepareForInterfaceBuilder
{
    NSArray *points = @[ [NSValue valueWithCGPoint: CGPointMake(0, 50)],
                         [NSValue valueWithCGPoint: CGPointMake(1, 65)],
                         [NSValue valueWithCGPoint: CGPointMake(2, 30)],
                         [NSValue valueWithCGPoint: CGPointMake(3, 45)],
                         [NSValue valueWithCGPoint: CGPointMake(4, 77)]];
    self.plotPoints = points;
}

#pragma mark - Drawing Helpers

- (void)drawRect: (CGRect)rect
{
    [super drawRect: rect];
    if (self.plotPoints.count <= 1) return;
    
    //Reset the plot
    self.backgroundBezierPath = nil;
    self.trendBezierPath = nil;
    self.plotCircles = [NSMutableSet new];
    
    //Draw plot points
    [self.plotPoints enumerateObjectsUsingBlock: ^(NSValue *pointValue, NSUInteger idx, BOOL *stop) {
        CGPoint point = [self transformPoint: [pointValue CGPointValue] intoFrame: rect totalPoints: self.plotPoints.count maxHeight: 100];
        [self addPointToBackgroundPath: point inRect: rect];
        [self addPointToTrendBezierPath: point inRect: rect];
        if (self.plotPointVisible) [self addMarkerToPoint: point];
    }];
    
    //Finalize the paths
    [self finalizePathsInRect: rect];
    
    //Draw shit
    [self drawPlot];
}

- (void)addPointToBackgroundPath: (CGPoint)point inRect: (CGRect)rect
{
    //First point takes some special setup
    if (!self.backgroundBezierPath)
    {
        self.backgroundBezierPath = [UIBezierPath bezierPath];
        [self.backgroundBezierPath moveToPoint: CGPointMake(0, rect.size.height)];
    }
    
    //Add the plot point to the path
    [self.backgroundBezierPath addLineToPoint: point];
}

- (void)addPointToTrendBezierPath: (CGPoint)point inRect: (CGRect)rect
{
    //First point takes some special setup
    if (!self.trendBezierPath)
    {
        self.trendBezierPath = [UIBezierPath bezierPath];
        self.trendBezierPath.lineWidth = self.lineWidth;
        [self.trendBezierPath moveToPoint: point];
    }
    
    //Subsequent points are added
    else
        [self.trendBezierPath addLineToPoint: point];
}

- (void)addMarkerToPoint: (CGPoint)point
{
    UIBezierPath *circle = [UIBezierPath bezierPathWithArcCenter: point radius: self.plotPointRadius startAngle: 0 endAngle: 2 * M_PI clockwise: YES];
    circle.lineWidth = self.lineWidth;
    [self.plotCircles addObject: circle];
}

- (void)finalizePathsInRect: (CGRect)rect
{
    //Close the background path
    [self.backgroundBezierPath addLineToPoint: CGPointMake(rect.size.width, rect.size.height)];
    [self.backgroundBezierPath closePath];
}

- (void)drawPlot
{
    //Draw in context
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ref);
    
    //Set colors
    [self.lineColor setStroke];
    [self.fillColor setFill];
    
    //Stroke and fill the plot
    [self.backgroundBezierPath fill];
    [self.trendBezierPath stroke];
    
    //Set circle colors
    [self.backgroundColor setFill];
    [self.plotCircles makeObjectsPerformSelector: @selector(fill)];
    [self.plotCircles makeObjectsPerformSelector: @selector(stroke)];
    
    //Draw plot title
    [self.plotTitle drawAtPoint: CGPointMake(8, 8) withAttributes: @{ NSForegroundColorAttributeName : self.lineColor}];
    
    CGContextRestoreGState(ref);
}

- (CGPoint)transformPoint: (CGPoint)point intoFrame: (CGRect)frame totalPoints: (NSInteger)totalPoints maxHeight: (CGFloat)maxHeight
{
    //Calculate new x pos
    CGFloat xIncrement = frame.size.width / (totalPoints - 1);
    CGFloat xValue = xIncrement * point.x;
    
    //Calculate new y pos
    CGFloat yIncrement = frame.size.height / maxHeight;
    CGFloat yValue = frame.size.height - (yIncrement * point.y);
    
    return CGPointMake(xValue, yValue);
}

@end
