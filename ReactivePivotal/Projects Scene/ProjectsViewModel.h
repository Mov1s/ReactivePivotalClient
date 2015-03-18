//
//  ProjectsViewModel.h
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VelocityViewModel;

@interface ProjectsViewModel : NSObject

/** The count of the user's currently active project */
@property (nonatomic, strong) NSNumber *activeProjectCount;

/** The user's projects */
@property (nonatomic, strong) NSArray *projects;

/** The count of the user's projects */
@property (nonatomic, strong) NSNumber *totalProjectCount;

/** Creates a new VelocityViewModel for a project
 @param projectIndex The index of the project in self.projects
 @return A VelocityViewModel
 */
- (VelocityViewModel *)velocityViewModelForProjectAtIndex: (NSInteger)projectIndex;

@end
