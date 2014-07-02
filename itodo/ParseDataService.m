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
static NSMutableSet * _projectListSet;
static NSMutableArray *_projectList;
static NSMutableArray *uniqueList;

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
  //  NSLog(@"list%@",_taskList[1]);
    return _taskList;
}

+(NSMutableArray *)getProjectListFromParseService:(NSString *)currentUser;
{
    _projectList=[[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"TaskList%@",currentUser]];
    [query selectKeys:@[@"project"]];
    _projectList=[[query findObjects]mutableCopy];
    
    _projectListSet=[[NSMutableSet alloc]init];
    for (PFObject *pobj in  _projectList) {
        NSString *temp=[pobj objectForKey:@"project"];
        [_projectListSet addObject:temp];
        
    }
    _projectList=[[_projectListSet allObjects]mutableCopy];
    
    
    //NSLog(@"projects in set:%@",_projectList);
    return _projectList;
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
