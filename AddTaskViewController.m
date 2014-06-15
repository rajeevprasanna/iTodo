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
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.dateTextField setInputView:datePicker];
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
@end
