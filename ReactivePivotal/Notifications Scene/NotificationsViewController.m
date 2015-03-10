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

/** The table view to show notifications in */
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation NotificationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Bind notifications
    @weakify(self);
    [RACObserve(self.viewModel, notifications) subscribeNext: ^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    return self.viewModel.notifications.count;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"notifcationCell"];
    NSDictionary *notification = self.viewModel.notifications[indexPath.row];
    
    //Configure cell
    cell.textLabel.text = notification[@"message"];
    cell.detailTextLabel.text = notification[@"context"];
    
    return cell;
}

@end
