//
//  ProjectsViewModel.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import "ProjectsViewModel.h"

@implementation ProjectsViewModel

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    //Set defaults
    self.totalProjectCount = @0;
    self.activeProjectCount = @0;
    
    return self;
}

@end
