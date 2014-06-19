//
//  AddTaskViewController.h
//  itodo
//
//  Created by ramesh on 10/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AddTaskViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *task;
@property (strong, nonatomic) IBOutlet UITextField *priority;
@property (nonatomic,strong) IBOutlet UITextField *dateTextField;
@property NSString *objectId;
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
//- (IBAction)EditTask:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *buttonView;
@property (strong, nonatomic) IBOutlet UIView *saveView;
@property (strong, nonatomic) IBOutlet  UIPickerView *myPickerView;
@property (strong, nonatomic)  NSArray *priorities;

@end
