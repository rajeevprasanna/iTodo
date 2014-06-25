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
static NSMutableSet * _projectLisArray;
static NSMutableArray *_projectList;
static NSString *temp;

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

+(NSMutableArray *)getProjectListFromParseServie:(NSString *)currentUser
{
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"TaskList%@",currentUser]];
    [query whereKeyExists:@"project"];
    PFObject *listData=[[query findObjects]mutableCopy];

//    NSArray *list=
    _projectList=listData[@"project"];
    NSLog(@"%@",_projectList);
    return _projectList;
}

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
    NSLog(@"projects:%@",_projectLisArray);
    return _projectLisArray;
}

@end
