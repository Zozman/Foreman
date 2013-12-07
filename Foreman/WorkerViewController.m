//
//  WorkerViewController.m
//  Foreman
//
//  Created by Zac Lovoy on 11/17/13.
//  Copyright (c) 2013 Zac Lovoy. All rights reserved.
//
//  This class is the view controller for the worker view tab

#import "WorkerViewController.h"
#import "Worker.h"
#import "Utilities.h"
#import "Json.h"
#import "UserData.h"
#import <dispatch/dispatch.h>

@interface WorkerViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WorkerViewController {
    // Controller Methods
    // Holds the data stored in the table
    NSMutableArray *tableData;
    // Stores how many workers are displayed
    NSInteger numWorkers;
    // Queue used for background tasks
    dispatch_queue_t backgroundQueue;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Function that runs when the view loads
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize background action queue
    backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // Add padding to the top and bottom of the table
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.tableView.contentInset = UIEdgeInsetsMake(0., 0., CGRectGetHeight(self.tabBarController.tabBar.frame), 0);
    
    
    // Add the "Pull To Refresh" option to the view
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(pullUpdateData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    // Update the data in the table
    dispatch_async(backgroundQueue,
                   ^ {
                       // Start animating update
                       [_spinningIndicator startAnimating];
                       // Update data
                       [self updateData];
                       // Update table
                       [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                       // Stop aniation
                       [_spinningIndicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
                   });
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Function that runs to stop the "Pull To Refresh" animation
- (void)stopRefresh
{
    [self.refreshControl endRefreshing];
}

// Function to update the table in the background
-(void)updateData {
    // Get the saved API key
     NSString *key = [Utilities retrieveKey];
    
    // If the key is not blank
    if (![key  isEqual: @""]) {
        @try {
            // Get the UserData
            UserData *usData = [Json getUserData:key];
            NSArray *sortedArray;
            // Sort the UserData by Worker name
            sortedArray = [[usData workerArray] sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                NSString *first = [(Worker*)a name];
                NSString *second = [(Worker*)b name];
                return [first compare:second];
            }];
            // Put the WorkerData in the right format
            NSMutableArray *newData = [Utilities convertWorkerArrayToTableArray:sortedArray];
            tableData = newData;
            numWorkers = [newData count]/6;
        }
        // If an error occurs, display error message
        @catch (NSException *e) {
            tableData = [NSMutableArray arrayWithObjects:@"No Data Found Pull To Refresh", nil];
            numWorkers = 1;
        }
    // If there is no API key
    } else {
        // Set error message
        tableData = [NSMutableArray arrayWithObjects:@"Enter API Key In Settings Tab", nil];
        numWorkers = 1;
    }
    // Stop the "Pull to Refresh" action
    [self performSelector:@selector(stopRefresh) withObject:nil];
    // Reload the table
    [self.tableView reloadData];
}

// Function that runs when the view goes back to this tab
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Reload the table data in the background
    [self pullUpdateData];
}

// Update data after a pull to refresh asyncronously
-(void)pullUpdateData {
    dispatch_async(backgroundQueue,
                   ^ {
                       [self updateData];
                   });
}

#pragma mark - Table view data source

// Function to return the number of sections in the table (used for table)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

// Function to return the number of rows per section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section (the number of workers)
    return [tableData count];
}

// Function that populates the table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    // Add the text to the table cell
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    // If the table row is a heading row (name of a worker), turn it blus
    if (indexPath.row % 6 == 0) {
        cell.backgroundColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 1.0 alpha: 1.0];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
