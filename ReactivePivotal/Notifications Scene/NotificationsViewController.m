//
//  NotificationsViewController.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NotificationsViewController.h"
#import "NotificationsViewModel.h"

@interface NotificationsViewController ()

/** The view model for this view controller */
@property (nonatomic, weak) IBOutlet NotificationsViewModel *viewModel;

@end

@implementation NotificationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Bind notifications
    [RACObserve(self.viewModel, notifications) subscribeNext: ^(id x) {
        //Refresh table
    }];
}

@end
