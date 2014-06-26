//
//  iValidationViewController.m
//  Registration
//
//  Created by ramesh on 04/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "HomepageViewController.h"
#import "ListViewController.h"
#import "ParseDataService.h"
#import "ParseCronService.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


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
    [self.userTextField becomeFirstResponder];
    // Do any additional setup after loading the view
    
    
    
}

/*-(IBAction)display{
    RegisterViewController *vc=[[RegisterViewController alloc]init];
    [vc load];
    self.uname.text=username;
    self.pswd.text=password;
    
    
}*/
- (IBAction)login:(id)sender {
    
    self.userTextField.text = @"h";
    self.passwordTextField.text = @"h";
    //comment the above hard coded credentials
    
    [PFUser logInWithUsernameInBackground:self.userTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error){
        if (!error)
        {
            ListViewController *iv=[self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
            [ParseDataService getTaskListFromParseService: self.userTextField.text];
            iv.currentUser=self.userTextField.text;
            [self presentViewController:iv animated:YES completion:nil];
            
            //After successful login, set up the cron to run regularly to alert user with timeout todo tasks
            [ParseCronService startCronJobForTimeOutTasks];
        }
        else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Login Failed" message:@"Invalid Username or Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    }];
    
}

    


    
    

    


-(void)move{
    HomepageViewController *ih=[self.storyboard instantiateViewControllerWithIdentifier:@"HomepageViewController"];
  //   ih.username1=username;
    
    [self presentViewController:ih animated:YES completion:nil];
    
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
