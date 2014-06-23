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

+(NSMutableArray *)getTaskListFromParseService:(NSString *)currentUser
{
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"TaskList%@",currentUser]];
    [query clearCachedResult];
//    [query findObjects:^(NSArray *objects, NSError *error) {
//        if (!error) {
//             _taskList = [objects mutableCopy];
//         }
//    }];
//    
    _taskList = [[query findObjects] mutableCopy];
    return _taskList;
}
@end
