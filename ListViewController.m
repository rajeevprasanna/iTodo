//
//  ListViewController.m
//  itodo
//
//  Created by ramesh on 17/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "ListViewController.h"
#import <Parse/Parse.h>
#import "AddTaskViewController.h"

@interface ListViewController ()
@property (strong, nonatomic) IBOutlet UIView *actionView;
@property NSString *objectID;

@end

@implementation ListViewController

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
    [self.TableView reloadData];
    
    self.actionView.hidden=YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    [self.TableView reloadData];
    
  //  self.navigationItem.rightBarButtonItem = self.editButtonItem;
    PFQuery *query = [PFQuery queryWithClassName:@"TaskList"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.list=[objects mutableCopy];
            [self.TableView reloadData];
            //[self performSelector:@selector(addTaskButtonPressed) withObject:nil afterDelay:2];
            
            self.TableView.scrollEnabled=YES;
         //   [self.TableView addSubview:self.actionView];
        }
    }];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ]; //forIndexPath:indexPath];
    
    // Configure the cell...
    PFObject *listData=[self.list objectAtIndex:indexPath.row];
    cell.textLabel.text=listData[@"task"];
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"Priority:%@",listData[@"priority"]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.actionView.hidden=NO;
    PFObject *edit=[self.list objectAtIndex:indexPath.row];
    self.objectID=edit.objectId;
    NSLog(@"Object id:%@",_objectID);
    
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *edit=[self.list objectAtIndex:indexPath.row];
    NSString *ObjectID=edit.objectId;
    NSLog(@"ObjectID is:%@",ObjectID);
    PFQuery *query = [PFQuery queryWithClassName:@"TaskList"];
    //  [self EditTask:ObjectID];
    self.objectID=ObjectID;
    // Retrieve the object by id
    
    
    
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *object = [self.list objectAtIndex:indexPath.row];
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [object saveInBackground];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
        [self viewDidLoad];
    }];
}



/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)addTaskButtonPressed:(id)sender {
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"edit"])
    {
        AddTaskViewController *editTask = segue.destinationViewController;
        editTask.objectId=self.objectID;
       // UIAlertView *alert=[[UITableView alloc]initwith]
    }
}


- (IBAction)EditTask:(id)sender {
    
    
    
}


@end
