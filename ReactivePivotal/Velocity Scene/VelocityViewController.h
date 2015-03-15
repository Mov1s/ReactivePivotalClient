//
//  VelocityViewController.h
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/10/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPViewController.h"
#import "VelocityViewModel.h"

@interface VelocityViewController : RPViewController

@property (nonatomic, strong) VelocityViewModel *viewModel;

@end
