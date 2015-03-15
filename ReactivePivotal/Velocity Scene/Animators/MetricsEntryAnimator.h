//
//  MetricsEntryAnimator.h
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/15/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface MetricsEntryAnimator : NSObject <UIDynamicAnimatorDelegate>

/** The parent view that the metrics are housed in
 This will normally be the root view of a view controller
 */
@property (nonatomic, weak) IBOutlet UIView *parentView;

/** The stat card view
 This will receive an entry animation
 */
@property (nonatomic, weak) IBOutlet UIView *sprintStatsCardView;

/** The plot showing velocity
 This is used for height calculations
 */
@property (nonatomic, weak) IBOutlet UIView *velocityPlotView;

/** The container showing the velocity plot
 This will receive an entry animation
 */
@property (nonatomic, weak) IBOutlet UIView *velocityPlotViewContainer;

/** Make the metrics views enter the screen
 This will trigger all of the animations to show the various metrics
 */
- (void)showMetrics;

@end
