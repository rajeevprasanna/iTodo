//
//  TaskListVIewTableViewController.h
//  itodo
//
//  Created by ramesh on 10/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskListVIewTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSMutableArray *list;
@property (strong,nonatomic) UITableView *myView;
- (IBAction)addTaskButtonPressed:(id)sender;
- (IBAction)EditTask:(id)sender;
@end
