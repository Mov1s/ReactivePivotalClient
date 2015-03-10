//
//  ProjectsViewModel.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ProjectsViewModel.h"
#import "PVRequestSignal.h"

@implementation ProjectsViewModel

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    //Set defaults
    self.totalProjectCount = @0;
    self.activeProjectCount = @0;
    
    //Request projects
    @weakify(self);
    [[PVRequestSignal requestProjects]
     
        //Executed when projects return
        subscribeNext: ^(NSArray *x) {
            @strongify(self);
            self.projects = x;
            self.totalProjectCount = [NSNumber numberWithInteger: x.count];
        }
     
        //Execute when projects request is an error
        error: ^(NSError *error) {
            @strongify(self);
            self.projects = @[];
            self.totalProjectCount = @0;
        }];
    
    return self;
}

@end
