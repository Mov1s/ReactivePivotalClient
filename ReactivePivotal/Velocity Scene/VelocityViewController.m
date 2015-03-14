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

@property (nonatomic, weak) IBOutlet UIView *plotContainer;

//The container view for showing sprint stats
@property (nonatomic, weak) IBOutlet UIView *sprintStatsContainer;

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation VelocityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.view];
    self.animator.delegate = self;
    
    //Bind activity indicator
    [[RACObserve(self.viewModel, velocityPlotPoints)
     
        map: ^id(NSArray *value) {
            return @(value.count != 0);
        }]
    
     subscribeNext: ^(NSNumber *completedWithItems) {
         self.activityIndicator.hidden = YES;
         if ([completedWithItems boolValue]) [self animateStatsContainerIn];
    }];
    
    //Bind plot
    RAC(self.plot, plotPoints) = RACObserve(self.viewModel, velocityPlotPoints);
}

#pragma mark - Animator Delegate Methods
- (void)dynamicAnimatorDidPause: (UIDynamicAnimator *)animator
{
    [animator removeAllBehaviors];
}

- (void)animateStatsContainerIn
{
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems: @[ self.sprintStatsContainer, self.plotContainer ]];
    gravity.gravityDirection = CGVectorMake(0, -3);
    [self.animator addBehavior: gravity];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems: @[ self.sprintStatsContainer ]];
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets: UIEdgeInsetsMake(198, 0, -10000, 0)];
    [self.animator addBehavior: collisionBehavior];
    
    UICollisionBehavior *plotCollisionBehavior = [[UICollisionBehavior alloc] initWithItems: @[ self.plotContainer ]];
    [plotCollisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets: UIEdgeInsetsMake(0, 0, -10000, 0)];
    [self.animator addBehavior: plotCollisionBehavior];
    
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems: @[ self.plotContainer ] mode: UIPushBehaviorModeInstantaneous];
    push.pushDirection = CGVectorMake(0, -500);
    [self.animator addBehavior: push];
}

@end
