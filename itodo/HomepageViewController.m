//
//  HomepageViewController.m
//  itodo
//
//  Created by ramesh on 06/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "HomepageViewController.h"
#import "ViewController.h"
@interface HomepageViewController ()

@end

@implementation HomepageViewController

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
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    self.username.text=[user objectForKey:@"username"];
    //NSLog(@"%@",username);
}


-(IBAction)move:(id)sender{
    ViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    //   ih.username1=username;
    
    [self presentViewController:vc animated:YES completion:nil];
    
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