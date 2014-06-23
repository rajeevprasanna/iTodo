//
//  ParseDataService.h
//  itodo
//
//  Created by ramesh on 23/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseDataService : NSObject
+(NSMutableArray *)getTaskListFromParseService:(NSString *)currentUser;
@end
