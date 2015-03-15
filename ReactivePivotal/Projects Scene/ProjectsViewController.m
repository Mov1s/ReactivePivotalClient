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
    NSString *segueIdentifier = segue.identifier;
    
    //Project metrics segue
    if ([segueIdentifier isEqualToString: @"projectMetricsSegue"])
    {
        //Get the index of the selected cell
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell: cell];
        
        //Get a view model for the project metrics
        VelocityViewModel *viewModel = [self.viewModel velocityViewModelForProjectAtIndex: selectedIndexPath.row];

        //Assign the view model
        VelocityViewController *controller = segue.destinationViewController;
        controller.viewModel = viewModel;
    }
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    return self.viewModel.projects.count;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    //Deselect the cell
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    //Get the cell and project
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"projectCell"];
    NSDictionary *project = self.viewModel.projects[indexPath.row];
    
    //Configure cell
    cell.textLabel.text = project[@"name"];
    
    return cell;
}

@end
