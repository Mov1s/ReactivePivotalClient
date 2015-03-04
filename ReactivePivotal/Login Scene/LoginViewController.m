//
//  LoginViewController.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/3/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LoginViewController.h"
#import "NSUserDefaults+Additions.h"
#import "PVRequestSignal.h"

@interface LoginViewController ()

//TextField containing the API Token
@property (nonatomic, weak) IBOutlet UITextField *apiTokenTextField;

//Button for continuing with the given token
@property (nonatomic, weak) IBOutlet UIButton *continueButton;

//An NSUserDefaults instance for storing and retrieving the api token
@property (nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize properties
    if (!self.userDefaults) self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    //Put the saved token in the text box if there is one
    self.apiTokenTextField.text = self.userDefaults.pivotalApiToken;
    
    //Set up the reactive pipelines
    [self setupTokenValidationPipeline];
    [self setupAuthenticationPipeline];
}

#pragma mark - Pipelines
//Token Validation Pipeline
//Handles the flow of disabling the "Continue" button until the entered token is valid
- (void)setupTokenValidationPipeline
{
    @weakify(self);
    
    //Evaluated each time the user types a character in the text field
    [[self.apiTokenTextField.rac_textSignal
      
        //Executed when a character is typed in the text field
        //Validates the API token
        map: ^id(NSString *apiKey) {
            @strongify(self);
            return @([self apiKeyIsValid: apiKey]);
        }]
     
        //Executed when a character is typed in the text field
        //Disables or enables the "Continue" button depending on the validity of the API token
        subscribeNext: ^(NSNumber *apiKeyIsValid) {
            @strongify(self);
            self.continueButton.enabled = [apiKeyIsValid boolValue];
        }];
}

//Authentication Pipeline
//Handles the flow of authenticating an API token starting from the moment the user presses "Continue"
- (void)setupAuthenticationPipeline
{
    @weakify(self);
    
    //It all begins when the user taps "Continue"
    [[[[self.continueButton rac_signalForControlEvents: UIControlEventTouchUpInside]
       
        //Executed when the button is pressed
        //Disables the form and saves the currently typed in API Key
        doNext: ^(id x) {
            @strongify(self);
            [self enableForm: NO];
            [self.userDefaults setPivotalApiToken: self.apiTokenTextField.text];
            [self.userDefaults synchronize];
        }]
      
        //Executed when the button is pressed
        //Starts a request for user profile information
        flattenMap: ^RACStream *(id value) {
            return [[PVRequestSignal requestMe]
                    
                    //Executed when the request fails
                    //Enables the form and shows the error message
                    catch: ^RACSignal *(NSError *error) {
                        @strongify(self);
                        //TODO: Show error
                        [self enableForm: YES];
                        return [RACSignal empty];
                    }];
        }]
     
        //Executed when the user profile request returns successfully
        //Enables the form and segues to the next controller
        subscribeNext: ^(id x) {
            @strongify(self);
            [self enableForm: YES];
            [self performSegueWithIdentifier: @"loginSuccessSegue" sender: self];
        }];
}

#pragma mark - Helpers
//Checks if the API key seems valid
- (BOOL)apiKeyIsValid: (NSString *)apiKey
{
    return apiKey.length >= 32;
}

//Disables or enables the login form user interaction
- (void)enableForm: (BOOL)shouldEnable
{
    if (!shouldEnable) [self.apiTokenTextField resignFirstResponder];
    self.apiTokenTextField.enabled = shouldEnable;
    self.continueButton.enabled = shouldEnable;
}

@end
