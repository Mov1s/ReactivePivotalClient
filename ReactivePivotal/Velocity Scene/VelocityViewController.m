//
//  VelocityViewController.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "VelocityViewController.h"

@interface VelocityViewController ()

//Activity indicator to show the progress of velocity calculations
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation VelocityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Bind plot data
    RAC(self.activityIndicator, hidden) = [RACObserve(self.viewModel, velocityPlotPoints) map: ^id(NSArray *value) {
        return @(value.count != 0);
    }];
}

@end
