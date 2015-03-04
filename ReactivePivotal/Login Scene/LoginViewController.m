//
//  LoginViewController.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/3/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

//TextField containing the API Token
@property (nonatomic, weak) IBOutlet UITextField *apiTokenTextField;

//Button for continuing with the given token
@property (nonatomic, weak) IBOutlet UIButton *continueButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
