//
//  VelocityViewModel.h
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VelocityViewModel : NSObject

/** The project ID */
@property (nonatomic, strong) NSNumber *projectId;

/** The project name */
@property (nonatomic, strong) NSString *projectName;

/** An array of plot points for being displayed in a plot */
@property (nonatomic, strong) NSArray *velocityPlotPoints;

/** Create a new view model with the given projectID */
- (instancetype)initWithProjectId: (NSNumber *)projectId;

@end
