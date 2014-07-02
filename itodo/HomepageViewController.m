//
//  HomepageViewController.m
//  itodo
//
//  Created by ramesh on 06/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "HomepageViewController.h"
#import "ViewController.h"
#import "AddTaskViewController.h"
@interface HomepageViewController ()

@end

@implementation HomepageViewController
@synthesize username1;
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
    
    self.username.text=username1;
    NSUserDefaults *userCredentials=[NSUserDefaults standardUserDefaults];
    self.currentUser=[userCredentials objectForKey:@"username"];
    
    
}


-(IBAction)move:(id)sender{
    [PFUser logOut];
    ViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    //   ih.username1=username;
    
    [self presentViewController:vc animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
        if([segue.identifier isEqualToString:@"addTask"])
        {
            AddTaskViewController *at = segue.destinationViewController;
            at.currentUser=username1;
        }

}



@end
