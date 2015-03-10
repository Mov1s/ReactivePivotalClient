//
//  PVRequestSignal.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/3/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSMutableURLRequest+Additions.h"
#import "NSString+Additions.h"
#import "PVRequestSignal.h"

@implementation PVRequestSignal

//Returns information from the user's profile plus the list of projects to which the user has access.
+ (RACSignal *)requestMe
{
    return [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
    
        NSLog(@"Starting request");
        
        //Create the request
        NSString *routeString = @"https://www.pivotaltracker.com/services/v5/me";
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithAuthenticatedPivotalURL: [NSURL URLWithString: routeString]];
        
        //Create a request operation for serializing the response as JSON
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest: request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        //Completion blocks
        [operation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {
            
            //Success
            NSLog(@"Request success");
            [subscriber sendNext: responseObject];
            [subscriber sendCompleted];
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            
            //Failure
            NSLog(@"Request failed");
            [subscriber sendError: error];
        }];
        
        //Send the request
        [operation start];
        
        return nil;
    }];
}

//Return list of the notifications for the authenticated person. Response is sorted by notification created_at, most recent first.
+ (RACSignal *)requestNotifications
{
    return [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSLog(@"Starting request");
        
        //Create the request
        NSString *routeString = @"https://www.pivotaltracker.com/services/v5/my/notifications";
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithAuthenticatedPivotalURL: [NSURL URLWithString: routeString]];
        
        //Create a request operation for serializing the response as JSON
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest: request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        //Completion blocks
        [operation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {
            
            //Success
            NSLog(@"Request success");
            [subscriber sendNext: responseObject];
            [subscriber sendCompleted];
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            
            //Failure
            NSLog(@"Request failed");
            [subscriber sendError: error];
        }];
        
        //Send the request
        [operation start];
        
        return nil;
    }];
}

@end
