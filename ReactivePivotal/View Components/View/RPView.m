//
//  RPView.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/13/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import "RPView.h"

@implementation RPView

- (void)setCornerRadius: (CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

@end
