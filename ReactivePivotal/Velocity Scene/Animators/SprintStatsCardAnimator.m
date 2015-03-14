//
//  SprintStatsCardAnimator.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/14/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import "SprintStatsCardAnimator.h"

@interface SprintStatsCardAnimator()

//The animator to use for the managed animations
@property (nonatomic, strong) UIDynamicAnimator *animator;

//A gesture recognizer used for scolling the card view
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

//Keeps track of the starting Y position of the stats card view when a pan gesture begins
@property (nonatomic) CGFloat panStartingYPosition;

@end

@implementation SprintStatsCardAnimator

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    //Initialize
    
    return self;
}

#pragma mark - Setters
//Sets the parent view and initializes the animator
- (void)setParentView: (UIView *)parentView
{
    _parentView = parentView;
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView: parentView];
    self.animator.delegate = self;
}

//Sets the sprint stats view and initializes the gesture recognizer
- (void)setSprintStatsCardView: (UIView *)sprintStatsCardView
{
    _sprintStatsCardView = sprintStatsCardView;
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(panGestureRecognizerDidPan:)];
    [sprintStatsCardView addGestureRecognizer: self.panGestureRecognizer];
}

#pragma mark - Actions
//Triggered when the pan gesture on the card view updates
- (void)panGestureRecognizerDidPan: (UIPanGestureRecognizer *)gestureRecognizer
{
    //Gesture begins, cancel all current animations
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        self.panStartingYPosition = self.sprintStatsCardView.frame.origin.y;
        [self.animator removeAllBehaviors];
    }
    
    //Gesture ends, apply velocity and snap behavior to keep the view visible
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled)
    {
        //Get current vertical velocity
        CGPoint gestureVelocity = [gestureRecognizer velocityInView: self.parentView];
        gestureVelocity.x = 0;
        
        //Create and add an inertia behavior
        UIDynamicItemBehavior *deceleration = [[UIDynamicItemBehavior alloc] initWithItems: @[ self.sprintStatsCardView ]];
        [deceleration addLinearVelocity: gestureVelocity forItem: self.sprintStatsCardView];
        deceleration.resistance = 2.0;
        [self.animator addBehavior: deceleration];
        
        //Calculate if the view has been scrolled outside of its alowed bounds
        BOOL anchorToTop = self.sprintStatsCardView.frame.origin.y > self.scrollingTopBoundsInset;
        BOOL anchorToBottom = self.sprintStatsCardView.frame.origin.y + self.sprintStatsCardView.frame.size.height < self.parentView.bounds.size.height - self.scrollingBottomBoundsInset;
        
        //If it has been scrolled outside of its alowed bounds create an attachment to pull it back in
        if (anchorToTop || anchorToBottom)
        {
            //Calculate the anchor Y position
            CGFloat anchorYPos = anchorToTop    ? self.scrollingTopBoundsInset :
                                 anchorToBottom ? self.parentView.bounds.size.height - self.scrollingBottomBoundsInset - self.sprintStatsCardView.bounds.size.height : 0;
            
            //Create and add an attachment behavior
            UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem: self.sprintStatsCardView attachedToAnchor: CGPointMake(self.sprintStatsCardView.center.x, anchorYPos + self.sprintStatsCardView.bounds.size.height / 2)];
            attachment.length = 0.0;
            attachment.damping = .5;
            attachment.frequency = 2;
            [self.animator addBehavior: attachment];
        }
    }
    
    //Gesture has been updated, move the card view to the scroll position
    else
    {
        CGPoint translation = [gestureRecognizer translationInView: self.parentView];
        CGRect currentFrame = self.sprintStatsCardView.frame;
        currentFrame.origin.y = self.panStartingYPosition + translation.y;
        self.sprintStatsCardView.frame = currentFrame;
    }
}

#pragma mark - UIDynamicAnimator Delegate Methods
//Triggered when all animations stop moving
//Removes all of the behaviors applied to views so that everything is in a clean state
- (void)dynamicAnimatorDidPause: (UIDynamicAnimator *)animator
{
    [self.animator removeAllBehaviors];
}

@end
