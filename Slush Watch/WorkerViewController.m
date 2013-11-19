//
//  WorkerViewController.m
//  Slush Watch
//
//  Created by Zac Lovoy on 11/17/13.
//  Copyright (c) 2013 Zozworks. All rights reserved.
//

#import "WorkerViewController.h"
#import "Worker.h"
#import "Utilities.h"
#import "Json.h"
#import "UserData.h"

@interface WorkerViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WorkerViewController {
    NSMutableArray *tableData;
    NSInteger numWorkers;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.tableView.contentInset = UIEdgeInsetsMake(0., 0., CGRectGetHeight(self.tabBarController.tabBar.frame), 0);
    
    [self updateData];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    
    [refresh addTarget:self action:@selector(updateData) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refresh;
    
    
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

- (void)stopRefresh

{
    [self.refreshControl endRefreshing];
}

-(void)updateData {
     NSString *key = [Utilities retrieveKey];
    
    if (![key  isEqual: @""]) {
        @try {
            UserData *usData = [Json getUserData:key];
            NSArray *sortedArray;
            sortedArray = [[usData workerArray] sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                NSString *first = [(Worker*)a name];
                NSString *second = [(Worker*)b name];
                return [first compare:second];
            }];
            NSMutableArray *newData = [Utilities convertWorkerArrayToTableArray:sortedArray];
            tableData = newData;
            numWorkers = [newData count]/6;
        }
        @catch (NSException *e) {
            tableData = [NSMutableArray arrayWithObjects:@"No Data Found Pull To Refresh", nil];
            numWorkers = 1;
        }
    } else {
        tableData = [NSMutableArray arrayWithObjects:@"Enter API Key In Settings Tab", nil];
        numWorkers = 1;
    }
    [self performSelector:@selector(stopRefresh) withObject:nil];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_global_queue(0, 0),
                   ^ {
                       [self updateData];
                   });
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
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
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
