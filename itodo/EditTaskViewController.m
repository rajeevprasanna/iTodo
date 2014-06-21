//
//  EditTaskViewController.m
//  itodo
//
//  Created by ramesh on 17/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "EditTaskViewController.h"
#import <Parse/Parse.h>
#import "ListViewController.h"
@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

@synthesize objectId;
@synthesize priorities;
@synthesize myPickerView;
@synthesize currentUser;
int count=1;

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
    self.myPickerView.hidden=YES;
    self.priorityVIew.hidden=YES;
    priorities = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", nil];

    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.dateTextField setInputView:datePicker];
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    [myPickerView setDataSource: self];
    [myPickerView setDelegate: self];
    self.priority.inputView = myPickerView;

    
    if ([self.objectId isEqualToString:@"add"]) {
        self.buttonView.hidden=YES;
    }
    else{
        self.saveView.hidden=YES;
        PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"TaskList%@",currentUser]];
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



#pragma mark - pickerView dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [priorities count];
}


#pragma mark - UIPickerView Delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [priorities objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Let's print in the console what the user had chosen;
    NSString *num=[NSString stringWithFormat:@"%@",[priorities objectAtIndex:row] ];
    self.priority.text=num;
    NSLog(@"Chosen item: %@", [priorities objectAtIndex:row]);
}





- (IBAction)cancel:(id)sender {
}

- (IBAction)EditTask:(id)sender {
    NSLog(@"UserName %@",currentUser);
    
     PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"TaskList%@",currentUser]];
    [PFQuery clearAllCachedResults];

    NSNumber  *aNum = [NSNumber numberWithInteger: [self.priority.text integerValue]];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *tasklist, NSError *error) {
        
        tasklist[@"task"] = self.task.text;
        tasklist[@"date"] = self.dateTextField.text;
        tasklist[@"priority"] = aNum;
        
        [tasklist saveInBackground];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];

        ListViewController *iv=[self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
          iv.currentUser=self.currentUser;
        [self presentViewController:iv animated:YES completion:nil];


        
        
        
    }];
    
}

#pragma mark priority buttons
- (IBAction)viewPriority:(id)sender {
    
    self.priorityVIew.hidden=NO;
    self.priorityToggler.hidden=YES;
}

- (IBAction)priority1:(id)sender1 {
    self.priority.text=@"1";
    
    self.priorityVIew.hidden=YES;
    self.priorityToggler.hidden=NO;
    
}

- (IBAction)priority2:(id)sender2 {
    self.priority.text=@"2";
    self.priorityVIew.hidden=YES;
    self.priorityToggler.hidden=NO;
}
- (IBAction)priority3:(id)sender3 {
    self.priority.text=@"3";
    self.priorityVIew.hidden=YES;
    self.priorityToggler.hidden=NO;
}
- (IBAction)priority4:(id)sender4 {
    self.priority.text=@"4";
    self.priorityVIew.hidden=YES;
    self.priorityToggler.hidden=NO;
}

- (IBAction)priority5:(id)sender5 {
    self.priority.text=@"5";
    self.priorityVIew.hidden=YES;
    self.priorityToggler.hidden=NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ListViewController *editTask = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"editCancel"])
        editTask.currentUser=self.currentUser;
    
}

@end
