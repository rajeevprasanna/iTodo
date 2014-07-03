//
//  AddProjectViewController.m
//  itodo
//
//  Created by ramesh on 25/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "AddProjectViewController.h"
#import "ParseDataService.h"
#import "ListViewController.h"
@interface AddProjectViewController ()

@end

@implementation AddProjectViewController
{
    NSMutableArray *allProjects;
}

@synthesize projectList;
@synthesize currentUser;
@synthesize myPickerView;

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
  //  self._currentUser=__currentUser;
    self.addTaskUnderProjectView.hidden=YES;
    NSUserDefaults *userCredentials=[NSUserDefaults standardUserDefaults];
    self.currentUser=[userCredentials objectForKey:@"username"];
    

    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    myPickerView.showsSelectionIndicator = YES;
  //  self.projectNameTextField.inputView = myPickerView;
    
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.date setInputView:datePicker];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.date.inputView;
    self.date.text = [NSString stringWithFormat:@"%@",picker.date];
}


- (IBAction)save:(id)sender {
    NSLog(@"PFUser name is %@",currentUser);
    if(!(([self.task.text isEqual:@""])||([self.date.text isEqual:@""])||([self.priority.text isEqual:@""])||([self.projectNameTextField.text isEqual:@""])))
    {
    
    PFObject *add=[[PFObject alloc]initWithClassName:[NSString stringWithFormat:@"TaskList%@",currentUser]];
    [PFQuery clearAllCachedResults];
    NSNumber  *aNum = [NSNumber numberWithInteger: [self.priority.text integerValue]];
    
    [add setObject:_projectNameTextField.text forKey:@"project"];
    [add setObject:_task.text forKey:@"task"];
    [add setObject:_date.text  forKey:@"date"];
    [add setObject:aNum forKey:@"priority"];
    [add  save];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
    ListViewController *iv=[self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
    //iv.currentUser=self.currentUser;
    
    [self presentViewController:iv animated:YES completion:nil];
    
}
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Some Field(s) are missing" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


-(void)getProjectListFromParseDataService
{
    allProjects=[[NSMutableArray alloc]init];
    allProjects=[ParseDataService getProjectListFromParseService:currentUser];
    NSLog(@"Projects are:%@",allProjects);
    
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

- (IBAction)addProjectButton:(id)sender {
    if ([self.projectNameTextField.text isEqualToString:@""]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Please enter the project name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else{
    self.addTaskUnderProjectView.hidden=NO;
        self.CancelButtonVIew.hidden=YES;
    }
}

@end
