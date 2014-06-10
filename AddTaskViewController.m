//
//  AddTaskViewController.m
//  itodo
//
//  Created by ramesh on 10/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "AddTaskViewController.h"
#import <Parse/Parse.h>

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

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

- (IBAction)save:(id)sender {
    
    PFObject *add=[[PFObject alloc]initWithClassName:@"SingleUserTodoList"];
    
    [add setObject:_task.text forKey:@"task"];
    [add setObject:_date.text  forKey:@"date"];
    [add setObject:_priority.text forKey:@"priority"];
    [add  saveInBackground];

}

- (IBAction)cancel:(id)sender {
}
@end
