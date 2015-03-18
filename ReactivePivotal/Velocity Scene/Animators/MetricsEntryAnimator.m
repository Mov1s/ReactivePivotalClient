//
//  MetricsEntryAnimator.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/15/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import "MetricsEntryAnimator.h"

@interface MetricsEntryAnimator()

//The animator to use for the managed animations
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation MetricsEntryAnimator

#pragma mark - Public Methods
//Make the metrics views enter the screen
- (void)showMetrics
{
    //Create and add the gravity to pull the metrics views to the top
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems: @[ self.sprintStatsCardView, self.velocityPlotViewContainer ]];
    gravity.gravityDirection = CGVectorMake(0, -3);
    [self.animator addBehavior: gravity];
    
    //Create and add the collision behavior for the plot container, this will set the collision boundary to the top of the parent view
    UICollisionBehavior *plotCollisionBehavior = [[UICollisionBehavior alloc] initWithItems: @[ self.velocityPlotViewContainer ]];
    [plotCollisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets: UIEdgeInsetsMake(0, 0, -10000, 0)];
    [self.animator addBehavior: plotCollisionBehavior];
    
    //Create and add the collision behavior for the stats card, this will set the collision boundary to the bottom of the velocity plot
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems: @[ self.sprintStatsCardView ]];
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets: UIEdgeInsetsMake(self.velocityPlotView.bounds.size.height, 0, -10000, 0)];
    [self.animator addBehavior: collisionBehavior];
    
    //Create and add a push force that will cause the velocity plot container to move quicker than the stats card
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems: @[ self.velocityPlotViewContainer ] mode: UIPushBehaviorModeInstantaneous];
    push.pushDirection = CGVectorMake(0, -500);
    [self.animator addBehavior: push];
}

#pragma mark - Setters
//Sets the parent view and initializes the animator
- (void)setParentView: (UIView *)parentView
{
    _parentView = parentView;
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView: parentView];
    self.animator.delegate = self;
}

#pragma mark - UIDynamicAnimator Delegate Methods
//Triggered when all animations stop moving
//Removes all of the behaviors applied to views so that everything is in a clean state
- (void)dynamicAnimatorDidPause: (UIDynamicAnimator *)animator
{
    [self.animator removeAllBehaviors];
}

@end
