//
//  LoginViewModel.h
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/7/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef NS_ENUM(NSUInteger, RPApiKeyValidationRequestState) {
    RPApiKeyValidationRequestStateNotValidating,
    RPApiKeyValidationRequestStateValidating,
    RPApiKeyValidationRequestStateValidated,
};

@interface LoginViewModel : NSObject

/** The API key to use for pivotal */
@property (nonatomic, strong) NSString *apiKey;

/** Indicates if the current api key appears valid */
@property (nonatomic) BOOL apiKeyIsValid;

/** Indicates the current state of validation
 This is done by making an API request
 */
@property (nonatomic) RPApiKeyValidationRequestState apiKeyValidationState;

/** Action for validating the API token */
- (IBAction)validateApiKey: (id)sender;

@end
