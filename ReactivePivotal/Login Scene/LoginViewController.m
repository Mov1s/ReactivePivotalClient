//
//  LoginViewController.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/3/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LoginViewController.h"
#import "LoginViewModel.h"

@interface LoginViewController ()

//TextField containing the API Token
@property (nonatomic, weak) IBOutlet UITextField *apiTokenTextField;

//Button for continuing with the given token
@property (nonatomic, weak) IBOutlet UIButton *continueButton;

//The view model to bind to
@property (nonatomic, weak) IBOutlet LoginViewModel *viewModel;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Bind the text field
    self.apiTokenTextField.text = self.viewModel.apiKey;
    [self.apiTokenTextField.rac_textSignal subscribeNext: ^(NSString *x) {
        self.viewModel.apiKey = x;
    }];
    
    //Bind the validation signal
    RAC(self.continueButton, enabled) = RACObserve(self.viewModel, apiKeyIsValid);
    
    //Bind the validating signal
    [RACObserve(self.viewModel, apiKeyValidationState) subscribeNext: ^(NSNumber *state) {
        [self enableForm: [state unsignedIntegerValue] != RPApiKeyValidationRequestStateValidating];
        if ([state unsignedIntegerValue] == RPApiKeyValidationRequestStateValidated) [self performSegueWithIdentifier: @"loginSuccessSegue" sender: self];
    }];
}

#pragma mark - Helpers
//Disables or enables the login form user interaction
- (void)enableForm: (BOOL)shouldEnable
{
    if (!shouldEnable) [self.apiTokenTextField resignFirstResponder];
    self.apiTokenTextField.enabled = shouldEnable;
    self.continueButton.enabled = shouldEnable;
}

@end
