//
//  LoginViewModel.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/7/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import "LoginViewModel.h"
#import "NSUserDefaults+Additions.h"
#import "PVRequestSignal.h"

@interface LoginViewModel()

//An NSUserDefaults instance for storing and retrieving the api token
@property (nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation LoginViewModel

- (instancetype)init
{
    //Initialize
    self = [super init];
    if (!self) return nil;
    
    //Initialize properties
    if (!self.userDefaults) self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    //Retrieve the saved token if there is one
    self.apiKey = self.userDefaults.pivotalApiToken;
    
    //Bind valid token flag
    RAC(self, apiKeyIsValid) = [RACObserve(self, apiKey) map: ^id(NSString *value) {
        return @([self apiKeyIsValid: value]);
    }];
    
    return self;
}

#pragma mark - Actions
//Action for validating the API key
//This is responsible for make a validation request
- (IBAction)validateApiKey: (id)sender
{
    //Save the api key
    [self.userDefaults setPivotalApiToken: self.apiKey];
    [self.userDefaults synchronize];
    
    //Indicates validation request has started
    self.apiKeyValidationState = RPApiKeyValidationRequestStateValidating;
    
    @weakify(self);
    [[PVRequestSignal requestMe]
     
        //Executed on error
        //Indicates the validation request has finished
        subscribeError: ^(NSError *error) {
            @strongify(self);
            self.apiKeyValidationState = RPApiKeyValidationRequestStateNotValidating;
        }
     
        //Executed on success
        //Segues
        completed: ^{
            @strongify(self);
            self.apiKeyValidationState = RPApiKeyValidationRequestStateValidated;
        }];
}

#pragma mark - Helpers
//Checks if the API key seems valid
- (BOOL)apiKeyIsValid: (NSString *)apiKey
{
    return apiKey.length >= 32;
}

@end
