//
//  TaskListViewController.m
//  itodo
//
//  Created by Rajeev Kumar on 02/07/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "TaskListViewController.h"
#import "ParseDataService.h"

@interface TaskListViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation TaskListViewController
{
    NSArray * _tasks;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableSet *tasksSet  = [ParseDataService getTaskListFromParseService:self.userName withProject:self.projectName];
    _tasks = [tasksSet allObjects];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tasks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UILabel *taskNameLabel = (id)[cell viewWithTag:100];
    taskNameLabel.text = _tasks[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
