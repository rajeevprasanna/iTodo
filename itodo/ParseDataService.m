//
//  ParseDataService.m
//  itodo
//
//  Created by ramesh on 23/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "ParseDataService.h"

@implementation ParseDataService

static NSMutableArray * _taskList;
static NSSet * _projectListSet;
static NSMutableArray *_projectList;
static NSString *temp;
static NSArray *temp1;

+(NSMutableArray *)getTaskListFromParseService:(NSString *)currentUser
{
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"TaskList%@",currentUser]];
    //[query whereKey:@"project" equalTo:@"abcdef"];
    [query clearCachedResult];
//    [query findObjects:^(NSArray *objects, NSError *error) {
//        if (!error) {
//             _taskList = [objects mutableCopy];
//         }
//    }];
//
    [query orderByAscending:@"priority"];
    _taskList = [[query findObjects] mutableCopy];
    return _taskList;
}

+(NSSet *)getProjectListFromParseServie:(NSString *)currentUser
{
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"TaskList%@",currentUser]];
    [query selectKeys:@[@"project"]];
    _projectList=[[query findObjects]mutableCopy];
   // NSLog(@"%@",[query["project"]);
    temp1=[[NSSet setWithArray:_projectList]allObjects];
    _projectListSet=temp1;
   // NSLog(@"projects:%@",_projectList);
    NSLog(@"projects in set:%@",temp1);
    return _projectListSet;
}

/*
+(NSMutableSet *)getTaskListFromParseService:(NSString *)currentUser withProject:(NSString *)project;
{
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"TaskList%@",currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for (PFObject *person in objects){
            
            temp = [person objectForKey:@"project"];
            
            if (![_projectList containsObject:temp]) {
                
                [_projectList addObject:temp];
            }
        }
        }];
    NSLog(@"projects:%@",_projectListArray);
    return _projectListArray;
    return NuLL;
}*/

@end
