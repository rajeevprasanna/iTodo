//
//  iViewController.m
//  Registration
//
//  Created by ramesh on 04/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *email;

@end

@implementation RegisterViewController
-(IBAction)register:(id)sender {
    if(!(([self.username.text isEqual:@""])||([self.password.text isEqual:@""])||([self.email.text isEqual:@""])))
    {
        NSUserDefaults *save=[NSUserDefaults standardUserDefaults];
        [save setObject:self.username.text forKey:@"username"];
        [save setObject:self.password.text forKey:@"password"];
        [save setObject:self.email.text forKey:@"email"];
        
        LoginViewController *iv=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        iv.username=self.username.text;
        iv.password=self.password.text;
        iv.email=self.email.text;
        [self presentViewController:iv animated:YES completion:nil];
        
        UIAlertView *msg=[[UIAlertView alloc] initWithTitle:@"Registration is Successfull" message:@"Now you can access the app " delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
        [msg show];
    }
    else
    {
        
        UIAlertView *msg=[[UIAlertView alloc] initWithTitle:@"Registration Failed" message:@"Please fill all the fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [msg show];
        
    }
    
}
-(void)load
{
    NSUserDefaults *load=[NSUserDefaults standardUserDefaults];
    LoginViewController *iv=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    iv.username=[load objectForKey:@"username"];
    iv.password=[load objectForKey:@"password"];
    iv.email=[load objectForKey:@"email"];
    
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.username becomeFirstResponder];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}   


@end
