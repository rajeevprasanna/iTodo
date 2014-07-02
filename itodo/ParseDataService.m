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
 
static NSString *temp;
static NSSet *temp1;

+(NSMutableArray *)getAlreadyLoadedTasks:(NSString *)currentUser
{
    if(_taskList == nil){
        _taskList = [self getTaskListFromParseService:currentUser];
    }
    return _taskList;
} 
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


+(NSMutableSet *)getTaskListFromParseService:(NSString *)currentUser withProject:(NSString *)project
{
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"TaskList%@",currentUser]];
    NSArray*  responseTaskListByProject =   [query findObjects];
    
    
    NSMutableSet *taskListByProject = [NSMutableSet new];
    if(responseTaskListByProject){
        for (PFObject *person in responseTaskListByProject){
            NSString *projectName = [person objectForKey:@"project"];
            NSString *taskName = [person objectForKey:@"task"];
            if([projectName isEqualToString:project] && taskName){
                [taskListByProject addObject:taskName];
            }
        }
    }
         
    NSLog(@"projects:%@",taskListByProject);
    return taskListByProject;
}

@end
