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
#import "AddProjectViewController.h"


@interface ListViewController ()
@property (strong, nonatomic) IBOutlet UIView *actionView;
@property NSString *objectID;
//@property int selectedRow;

@end

@implementation ListViewController
{
    UIActivityIndicatorView *_spinner;
    NSInteger _selectedRow;
    NSMutableArray *_editStatusForRows;
}
@synthesize currentUser;
long flag=0;
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
    
    NSUserDefaults *userCredentials=[NSUserDefaults standardUserDefaults];
    self.currentUser=[userCredentials objectForKey:@"username"];
    
    [self.TableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];

    
    self.actionView.hidden=YES;
    self.dropdownView.hidden=YES;
    NSLog(@"User:%@",currentUser);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
    _spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _spinner.center = CGPointMake(160, 240) ;
    _spinner.hidesWhenStopped = YES;
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
    
    
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
    [self initializeDefaultEditValues];
    [self loadDataFromServer];
}

-(void)loadDataFromServer
{
    [_spinner startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.list  =  [ParseDataService getTaskListFromParseService:currentUser];
        [self initializeDefaultEditValues];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_spinner stopAnimating];
            [self.TableView reloadData];
        });
    });
}

-(void)initializeDefaultEditValues
{
     NSInteger  count = self.list.count;
    _editStatusForRows = [[NSMutableArray alloc]initWithCapacity:self.list.count];
    for(NSInteger i  =0 ;i<count;i++){
        _editStatusForRows[i] = @YES;
    }
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
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@:%@",listData[@"project"],listData[@"priority"]];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor redColor];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected RowIndex is:%ld",(long)indexPath.row);
    _selectedRow = indexPath.row;
    
    //for the first click, set the hide status to NO. for the next click, set its status to YES in array
    bool actionViewHideStatus = [_editStatusForRows[indexPath.row] intValue];
    if(actionViewHideStatus && actionViewHideStatus == YES){
        _editStatusForRows[indexPath.row] = @NO;
    }else{
        _editStatusForRows[indexPath.row] = @YES;
    }
    
    self.actionView.hidden = [_editStatusForRows[indexPath.row] intValue];
    
    PFObject *edit=[self.list objectAtIndex:indexPath.row];
    
    self.objectID=edit.objectId;
//    NSLog(@"Object id:%@",_objectID);
    [self updateBackGroundColorOfStatus:tableView withIndexPath:indexPath];
//    flag1=flag;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _editStatusForRows[indexPath.row] = @YES;
    [self updateBackGroundColorOfStatus:tableView withIndexPath:indexPath];
}

-(void)updateBackGroundColorOfStatus:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if([_editStatusForRows[indexPath.row] intValue] == 1){
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    else{
       cell.selectedBackgroundView.backgroundColor = [UIColor blueColor];
    }
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
        [object delete];
        [object saveInBackground];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
        [self viewDidLoad];
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
//    [self.TableView beginUpdates];
    PFObject *object = [PFObject objectWithoutDataWithClassName:[NSString stringWithFormat:@"TaskList%@",currentUser]
                                                       objectId:_objectID];
    [object deleteEventually];

    if(_selectedRow >= 0){
        [self.list removeObjectAtIndex: _selectedRow];
        [self.TableView reloadData];
    }
//    NSLog(@"task:%@",_objectID);
//    [self.TableView endUpdates];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];

//      [self loadDataFromServer];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"edit"])
    {
        EditTaskViewController *editTask = segue.destinationViewController;
        editTask.objectId=self.objectID;
        editTask.currentUser=self.currentUser;
       // UIAlertView *alert=[[UITableView alloc]initwith]
    }else
    if ([segue.identifier isEqualToString:(@"addTask")]) {
        AddTaskViewController *at=segue.destinationViewController;
        at.currentUser=self.currentUser;
    }else
    if ([segue.identifier isEqualToString:@"addProject"]) {
        AddProjectViewController *adprjct=segue.destinationViewController;
        adprjct.currentUser=self.currentUser;
    }
}



- (IBAction)refreshData:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshTable" object:self];
    
    [self.TableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
    
    [self viewDidLoad];
    

}


- (IBAction)dropDownButton:(id)sender {
    if (flag%2==0) {
        self.dropdownView.hidden=NO;
    }
    else{
        self.dropdownView.hidden=YES;
    }
    flag++;
}



- (IBAction)Logout:(id)sender {
    [PFUser logOut];
    [PFUser currentUser];
    
    ViewController *iv=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    //iv.currentUser=self.currentUser;
    
    [self presentViewController:iv animated:YES completion:nil];
    
    
}
@end
