//
//  SprintStatsCardAnimator.h
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/14/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface SprintStatsCardAnimator : NSObject <UIDynamicAnimatorDelegate>

/** The parent view that the card is housed in
 This will normally be the root view of a view controller
 */
@property (nonatomic, weak) IBOutlet UIView *parentView;

/** Adjust the bottom bounds that the scrolling will be constrained to
 This is relative to the parent frame
 */
@property (nonatomic) IBInspectable CGFloat scrollingBottomBoundsInset;

/** Adjust the top bounds that the scrolling will be constrained to
 This is relative to the parent frame
 */
@property (nonatomic) IBInspectable CGFloat scrollingTopBoundsInset;

/** The stat card view
 This is what will recieve all of the animations
 */
@property (nonatomic, weak) IBOutlet UIView *sprintStatsCardView;

@end
