//
//  ProjectsViewController.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ProjectsViewController.h"
#import "ProjectsViewModel.h"
#import "VelocityViewController.h"
#import "VelocityViewModel.h"

@interface ProjectsViewController ()

//The label for showing active project count
@property (nonatomic, weak) IBOutlet UILabel *activeProjectCountLabel;

//The label for showing total project count
@property (nonatomic, weak) IBOutlet UILabel *projectCountLabel;

//The table view for showing projects
@property (nonatomic, weak) IBOutlet UITableView *tableView;

//The view model for this VC
@property (nonatomic, weak) IBOutlet ProjectsViewModel *viewModel;

@end

@implementation ProjectsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Bind projects
    @weakify(self);
    [RACObserve(self.viewModel, projects) subscribeNext: ^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    //Bind total count
    RAC(self.projectCountLabel, text) = [RACObserve(self.viewModel, totalProjectCount) map: ^id(NSNumber *value) {
        return [value stringValue];
    }];
    
    //Bind active count
    RAC(self.activeProjectCountLabel, text) = [RACObserve(self.viewModel, activeProjectCount) map: ^id(NSNumber *value) {
        return [value stringValue];
    }];
}

- (void)prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    VelocityViewController *controller = segue.destinationViewController;
    controller.viewModel = [[VelocityViewModel alloc] initWithProjectId: @994928];
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    return self.viewModel.projects.count;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"projectCell"];
    NSDictionary *project = self.viewModel.projects[indexPath.row];
    
    //Configure cell
    cell.textLabel.text = project[@"name"];
    
    return cell;
}

@end
