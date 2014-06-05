//
//  iViewController.m
//  Registration
//
//  Created by ramesh on 04/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "iViewController.h"
#import "iValidationViewController.h"
#import "iHomepageViewController.h"
@interface iViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *email;

@end

@implementation iViewController
- (IBAction)register:(id)sender {
    if(!(([self.username.text isEqual:@""])||([self.password.text isEqual:@""])||([self.email.text isEqual:@""])))
    {
    iValidationViewController *iv=[self.storyboard instantiateViewControllerWithIdentifier:@"iValidationViewController"];
    iv.username=self.username.text;
    iv.password=self.password.text;
    iv.email=self.email.text;
    [self presentViewController:iv animated:YES completion:nil];
    NSUserDefaults *save=[NSUserDefaults standardUserDefaults];
    [save setObject:self.username.text forKey:@"username"];
    [save setObject:self.password.text forKey:@"password"];
    [save setObject:self.email.text forKey:@"email"];
    
    UIAlertView *msg=[[UIAlertView alloc] initWithTitle:@"user Created" message:@"Registered Successfully" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
    [msg show];
    }
    else
    {
        
        UIAlertView *msg=[[UIAlertView alloc] initWithTitle:@"Registration failed" message:@"Some fields are missing" delegate:self cancelButtonTitle:@"back" otherButtonTitles:nil, nil];
        [msg show];

    }
   
    }
-(void)load
{
    NSUserDefaults *load=[NSUserDefaults standardUserDefaults];
    iValidationViewController *iv=[self.storyboard instantiateViewControllerWithIdentifier:@"iValidationViewController"];
    iv.username=[load objectForKey:@"username"];
    iv.password=[load objectForKey:@"password"];
    iv.email=[load objectForKey:@"email"];
    
    iHomepageViewController *ih=[[iHomepageViewController alloc]init];
    ih.username1=[load objectForKey:@"username"];
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}   


@end
