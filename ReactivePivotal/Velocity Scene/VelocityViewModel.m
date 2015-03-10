//
//  VelocityViewModel.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSArray+Additions.h"
#import "PVRequestSignal.h"
#import "VelocityViewModel.h"

@implementation VelocityViewModel

- (instancetype)initWithProjectId: (NSNumber *)projectId
{
    self = [super init];
    if (!self) return nil;
    
    //Initialize
    self.projectId = projectId;
    
    //Request iterations
    [[[[[PVRequestSignal requestIterationsForProject: self.projectId]
      
        //Executed when the iterations return
        //Constructs the plot points for the iterations on a background thread
        deliverOn: [RACScheduler schedulerWithPriority: RACSchedulerPriorityBackground]]
        map: ^id(NSArray *value) {
            
            return [value mapObjectsUsingBlock: ^id(NSDictionary *obj, NSUInteger idx) {
                CGPoint plotPoint = [self plotPointForIteration: obj atIndex: idx];
                return [NSValue valueWithCGPoint: plotPoint];
            }];
        }]
      
        //Executed when the plot points have been generated
        deliverOnMainThread]
        subscribeNext: ^(NSArray *x) {
            self.velocityPlotPoints = x;
            NSLog(@"Velocity points: %@", self.velocityPlotPoints);
        }
     
        //Executed when the iterations request errors out
        error: ^(NSError *error) {
            //Error
        }];
    
    return self;
}

//Generate a plot point for an iteration by summing up the story estimates
- (CGPoint)plotPointForIteration: (NSDictionary *)iteration atIndex: (NSInteger)index
{
    int sum = 0;
    for (NSDictionary *story in iteration[@"stories"])
        sum += [story[@"estimate"] intValue];
    return CGPointMake(index, sum);
}

@end
