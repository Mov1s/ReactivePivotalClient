//
//  RPPieChartSection.m
//  ReactivePivotal
//
//  Created by Ryan Popa on 3/13/15.
//  Copyright (c) 2015 RyanPopa. All rights reserved.
//

#import "RPPieChartSection.h"

@implementation RPPieChartSection

//Creates a new pie chart section with the given percentage and title.
+ (instancetype)pieChartSectionWithPercentage: (NSNumber *)percentage title: (NSString *)title
{
    RPPieChartSection *section = [RPPieChartSection new];
    section.percentage = percentage;
    section.title = title;
    return section;
}

@end
