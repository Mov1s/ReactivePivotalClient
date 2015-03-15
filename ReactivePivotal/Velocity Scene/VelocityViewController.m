//
//  VelocityViewController.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MetricsEntryAnimator.h"
#import "RPPlot.h"
#import "VelocityViewController.h"

@interface VelocityViewController ()

//Activity indicator to show the progress of velocity calculations
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

//Animator in charge of showing the various metric views
@property (nonatomic, weak) IBOutlet MetricsEntryAnimator *metricsEntryAnimator;

//The plot to show past iteration velocity
@property (nonatomic, weak) IBOutlet RPPlot *plot;

@end

@implementation VelocityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Bind activity indicator
    [[RACObserve(self.viewModel, velocityPlotPoints)
     
        //Triggered when plot points are created
        //Checks if there are any and returns a @1 or @0
        map: ^id(NSArray *value) {
            return @(value.count != 0);
        }]
    
        //Triggered when the plot points are created
        //Stops the loading animations and animates in the stats if necessary
        subscribeNext: ^(NSNumber *completedWithItems) {
            self.activityIndicator.hidden = YES;
            if ([completedWithItems boolValue]) [self.metricsEntryAnimator showMetrics];
        }];
    
    //Bind plot
    RAC(self.plot, plotPoints) = RACObserve(self.viewModel, velocityPlotPoints);
}

@end
