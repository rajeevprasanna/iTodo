//
//  EditTaskViewController.m
//  itodo
//
//  Created by ramesh on 17/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "EditTaskViewController.h"
#import <Parse/Parse.h>

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

@synthesize objectId;

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
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.dateTextField setInputView:datePicker];
    if ([self.objectId isEqualToString:@"add"]) {
        self.buttonView.hidden=YES;
    }
    else{
        self.saveView.hidden=YES;
        PFQuery *query = [PFQuery queryWithClassName:@"TaskList"];
        [query getObjectInBackgroundWithId:objectId block:^(PFObject *editTask, NSError *error) {
            // Do something with the returned PFObject in the gameScore variable.
            NSString *task1=[editTask objectForKey:@"task"];
            NSLog(@"task:%@",task1);
            self.task.text=task1;
            NSString *date1=[editTask objectForKey:@"date"];
            self.dateTextField.text=date1;
            int pr=[[editTask objectForKey:@"priority"]intValue];
            NSString *priority1=[NSString stringWithFormat:@"%d",pr];
            
            self.priority.text=priority1;
            UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Task:" message:task1 delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            
            
        }];
        
    }
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

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dateTextField.inputView;
    self.dateTextField.text = [NSString stringWithFormat:@"%@",picker.date];
}

- (IBAction)save:(id)sender {
    NSNumber  *aNum = [NSNumber numberWithInteger: [self.priority.text integerValue]];
    
    PFObject *add=[[PFObject alloc]initWithClassName:@"TaskList"];
    
    [add setObject:_task.text forKey:@"task"];
    [add setObject:_dateTextField.text  forKey:@"date"];
    [add setObject:aNum forKey:@"priority"];
    [add  saveInBackground];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
    
    
    
}

- (IBAction)cancel:(id)sender {
}

- (IBAction)EditTask:(id)sender {
    
    PFQuery *query = [PFQuery queryWithClassName:@"TaskList"];
    NSNumber  *aNum = [NSNumber numberWithInteger: [self.priority.text integerValue]];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *tasklist, NSError *error) {
        
        tasklist[@"task"] = self.task.text;;
        tasklist[@"date"] = self.dateTextField.text;
        tasklist[@"priority"] = aNum;
        
        [tasklist saveInBackground];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
        
        
        
        
    }];
    
}
@end
