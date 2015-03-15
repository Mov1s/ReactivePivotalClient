//
//  RPViewController.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/15/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import "RPViewController.h"
#import "UIColor+Additions.h"

@interface RPViewController ()

@end

@implementation RPViewController

- (void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];
    self.navigationController.navigationBar.tintColor = self.navigationBarTintColor ?: [UIColor colorWithHex: @"#47A361" alpha: 1.0];
}

@end
