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


@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize username;
@synthesize password;
@synthesize email;

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
    // Do any additional setup after loading the view
    
    
    
}

-(IBAction)display{
    RegisterViewController *vc=[[RegisterViewController alloc]init];
    [vc load];
    self.uname.text=username;
    self.pswd.text=password;
    
    
}
- (IBAction)login:(id)sender {
    RegisterViewController *vc=[[RegisterViewController alloc]init];
    [vc load];
    if([_userTextField.text isEqualToString:username]
       && [_passwordTextField.text isEqualToString:password])
    {
        UIAlertView *view= [[UIAlertView alloc]initWithTitle:@"login Successful" message:@"Welcome" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil  ];
        [view show];
        [self move];
        
        
    }
    else{
        UIAlertView *view= [[UIAlertView alloc]initWithTitle:@"login failed" message:@"Please Enter valid details" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil  ];
        [view show];
        
        
    }
    
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
