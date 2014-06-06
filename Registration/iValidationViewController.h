//
//  iValidationViewController.h
//  Registration
//
//  Created by ramesh on 04/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iValidationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *uname;
@property (weak, nonatomic) IBOutlet UILabel *pswd;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *email;
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end
