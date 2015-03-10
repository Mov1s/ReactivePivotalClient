//
//  VelocityViewController.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RPPlot.h"
#import "VelocityViewController.h"

@interface VelocityViewController ()

//Activity indicator to show the progress of velocity calculations
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

//Plot for showing velocity
@property (nonatomic, weak) IBOutlet RPPlot *plot;

@end

@implementation VelocityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Bind activity indicator
    RAC(self.activityIndicator, hidden) = [RACObserve(self.viewModel, velocityPlotPoints) map: ^id(NSArray *value) {
        return @(value.count != 0);
    }];
    
    //Bind plot
    RAC(self.plot, plotPoints) = RACObserve(self.viewModel, velocityPlotPoints);
}

@end
