//
//  iHomepageViewController.m
//  Registration
//
//  Created by ramesh on 05/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "iHomepageViewController.h"
#import "iValidationViewController.h"
#import "iViewController.h"

@interface iHomepageViewController ()

@end

@implementation iHomepageViewController
@synthesize username1;
@synthesize password1;
@synthesize email1;

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
 //   NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
   // NSString *user1=[user objectForKey:@"username"];
   // iViewController *iv=[[iViewController alloc]init];
    //[iv load];
  //  self.username.text=user1;
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
