//
//  ParseCronService.m
//  itodo
//
//  Created by Rajeev Kumar on 26/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "ParseCronService.h"
#import "ParseDataService.h"
#import "AppDelegate.h"

@implementation ParseCronService

static NSString *_currentUserName;
static NSString* dateFormatPattern = @"yyyy-MM-dd HH:mm:ss Z";
static NSDateFormatter *dateFormatter;

+(void)setUserName:(NSString *)loggedInUserName
{
    _currentUserName = loggedInUserName;
}

static dispatch_once_t once;

+(void)startCronJobForTimeOutTasks
{
    dispatch_once(&once, ^{
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(lookForTimeOutTasks) userInfo:nil repeats:YES];
    });
}

+(NSDate *)getCurrentDate
{
    NSDate *currentDate  = [NSDate date];
    return currentDate;
}

+(void)lookForTimeOutTasks
{
    NSLog(@"checking tasks for timeout ones");
    
    if(dateFormatter == nil){
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:dateFormatPattern];
    }
    
    NSArray *taskList;
    if(_currentUserName != nil){
        taskList = [ParseDataService getAlreadyLoadedTasks:_currentUserName];
    }
    
    NSInteger notificationCount = 0;
    if(taskList && taskList.count >0){
        for(NSInteger i =0 ;i< taskList.count;i++){
            PFObject *listData = taskList[i];
            NSString *dateString = listData[@"date"];
            
            if(dateString && dateString.length > 0){
                NSDate *dateObject = [dateFormatter dateFromString:dateString];
                NSDate *currentDate = [self getCurrentDate];
                
                if([dateObject compare:currentDate] ==  NSOrderedAscending){
                    NSLog(@"this one is expired time => date => %@", dateObject);
                    notificationCount ++;
                }
            }
            
        }
    }
    [self setNotificationOnAppIcon:notificationCount];
}

+(void)setNotificationOnAppIcon:(NSInteger)notificationCount
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = notificationCount;
}

@end
