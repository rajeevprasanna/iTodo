//
//  HomepageViewController.h
//  itodo
//
//  Created by ramesh on 06/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <parse/Parse.h>

@interface HomepageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (strong,nonatomic) NSString  *username1;
- (IBAction)move:(id)sender;

@end
