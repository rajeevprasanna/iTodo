//
//  ParseCronService.m
//  itodo
//
//  Created by Rajeev Kumar on 26/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "ParseCronService.h"

@implementation ParseCronService

static dispatch_once_t once;

+(void)startCronJobForTimeOutTasks
{
    dispatch_once(&once, ^{
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(lookForTimeOutTasks) userInfo:nil repeats:YES];
    });
}

+(void)lookForTimeOutTasks
{
    NSLog(@"checking tasks for timeout ones");
}

@end
