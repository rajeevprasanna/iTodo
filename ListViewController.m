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
#import "EditTaskViewController.h"
#import "ViewController.h"
#import "ParseDataService.h"

@interface ListViewController ()
@property (strong, nonatomic) IBOutlet UIView *actionView;
@property NSString *objectID;
@property int selectedRow;

@end

@implementation ListViewController
@synthesize currentUser;
long flag=0,flag1=0;

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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];

    
    self.actionView.hidden=YES;
    self.dropdownView.hidden=YES;
    NSLog(@"User:%@",currentUser);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
//    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
//                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    spinner.center = CGPointMake(160, 240);
//    spinner.hidesWhenStopped = YES;
//    [self.view addSubview:spinner];
//    [spinner startAnimating];

    
    
//    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"TaskList%@",currentUser]];
//    [query clearCachedResult];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    
//            sleep(0.06);
//            self.list=[objects mutableCopy];
//            self.list = [ParseDataService getTaskListFromParseService:currentUser];
//            [self.TableView reloadData];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
            //[query setLimit:1000];
            

//            [spinner stopAnimating];
         //   [self refreshData:nil];
            //[self performSelector:@selector(addTaskButtonPressed) withObject:nil afterDelay:2];
            
            self.TableView.scrollEnabled=YES;
         //   [self.TableView addSubview:self.actionView];
        }
//    }];

//}

-(void)viewWillAppear:(BOOL)animated
{
   self.list = [ParseDataService getTaskListFromParseService:currentUser];
   self.TableView.scrollEnabled=YES;
}

-(void)reloadTable
{
    NSLog(@"realoding table after receiving notification");
    [self.TableView reloadData];
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
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
    }
    // Configure the cell...
    
    PFObject *listData=[self.list objectAtIndex:indexPath.row];
    cell.textLabel.text=listData[@"task"];
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"Priority:%@",listData[@"priority"]];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor redColor];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"RowIndex is:%ld",(long)indexPath.row);
    flag=indexPath.row;
    if ([self.list count]==1) {
        self.actionView.hidden=NO;
        if (flag%2==0) {
            self.actionView.hidden=YES;
        }
        else{
            self.actionView.hidden=NO;
        }
    }
    if (flag!=0 && flag==flag1)
    {
        self.actionView.hidden=YES;
    }
    if (flag!=flag1) {
        self.actionView.hidden=NO;
    }
    
    else{
        self.actionView.hidden=YES;
    }
    //self.selectedRow=indexPath.row;
    PFObject *edit=[self.list objectAtIndex:indexPath.row];

    self.objectID=edit.objectId;
    NSLog(@"Object id:%@",_objectID);
    flag1=flag;     
}


-(void)clearData
{
 //   [self.list removeAllObjects];
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


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.TableView reloadData];
    //[self.list removeAllObjects];
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

- (IBAction)deleteTask:(id)sender {
    [self.TableView beginUpdates];
    [self.TableView beginUpdates];
    PFObject *object = [PFObject objectWithoutDataWithClassName:[NSString stringWithFormat:@"TaskList%@",currentUser]
                                                       objectId:_objectID];
    [object deleteEventually];
  //  [self.list removeObjectAtIndex:self.selectedRow];
   
    NSLog(@"task:%@",_objectID);
    [self.TableView endUpdates];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];

    [self.TableView reloadData];
    [self viewDidLoad];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"edit"])
    {
        EditTaskViewController *editTask = segue.destinationViewController;
        editTask.objectId=self.objectID;
        editTask.currentUser=self.currentUser;
       // UIAlertView *alert=[[UITableView alloc]initwith]
    }
    if ([segue.identifier isEqualToString:(@"addTask")]) {
        AddTaskViewController *at=segue.destinationViewController;
        at.currentUser=self.currentUser;
    }
}



- (IBAction)refreshData:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshTable" object:self];
    
    [self.TableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
    
    [self viewDidLoad];
    

}


- (IBAction)dropDownButton:(id)sender {
    self.dropdownView.hidden=NO;
}
- (IBAction)Logout:(id)sender {
    [PFUser logOut];
    [PFUser currentUser];
    
    ViewController *iv=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    //iv.currentUser=self.currentUser;
    
    [self presentViewController:iv animated:YES completion:nil];
    
    
}
@end
