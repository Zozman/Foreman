//
//  StatsViewController.m
//  Foreman
//
//  Created by Zac Lovoy on 11/17/13.
//  Copyright (c) 2013 Zac Lovoy. All rights reserved.
//
//  The class is the view controller for the Stats screen

#import "Utilities.h"
#import "UserData.h"
#import "Json.h"
#import "StatsViewController.h"
#import "BitstampData.h"
#import "UIImage+QRCodeGenerator.h"
#import "CustomIOS7AlertView.h"
#import <dispatch/dispatch.h>

@interface StatsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation StatsViewController {
    // Members
    // Holds the data stored in the table
    NSMutableArray *tableData;
    // Holds current values of Bitcoins from Bitstamp
    BitstampData *bd;
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

// Function when the view is loaded for the first time
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
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
                       [_spinningUpdater startAnimating];
                       // Update data
                       [self updateData];
                       // Update table
                       [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                       // Stop aniation
                       [_spinningUpdater performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
                   });
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

// Function that runs to stop the "Pull To Refresh" animation
- (void)stopRefresh
{
    [self.refreshControl endRefreshing];
}

// Function to update the User Data in the table
-(void)updateData {
    // Refresh Bitstamp Data
    bd = [Json getBitstampData];
    
    // Retrieve the saved API Key
    NSString *key = [Utilities retrieveKey];
    
    // If the API Key is not blank, retrieve the data
    if (![key  isEqual: @""]) {
        @try {
            // Get the UserData from the server
            UserData *usData = [Json getUserData:key];
            // Convert the UserData into a table insertable form
            NSMutableArray *newData = [Utilities convertUserDataToTableArray:usData];
            tableData = newData;
        }
        // If the data can't be retrieved, display error
        @catch (NSException *e) {
            tableData = [NSMutableArray arrayWithObjects:@"No Data Found Pull To Refresh", nil];
        }
    // If the API Key is blank, display message to enter Key on settings page
    } else {
        tableData = [NSMutableArray arrayWithObjects:@"Enter API Key In Settings Tab", nil];
    }
    // End "Pull To Refresh" animation
    [self performSelector:@selector(stopRefresh) withObject:nil];
    // Reload the table
    [self.tableView reloadData];
}

// Update data after a pull to refresh asyncronously
-(void)pullUpdateData {
    dispatch_async(backgroundQueue,
                   ^ {
                       [self updateData];
                   });
}

// Function that runs when the view goes back to this tab
- (void)viewWillAppear:(BOOL)animated {
    // Reload the table data in the background
    [super viewWillAppear:animated];
    [self pullUpdateData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    // Return the number of rows in the section (the number of rows in the tableData)
    return [tableData count];
}

// Function that populates the table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    
    // Add text to table cell
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    // If the row is a label row, turn it blue
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 1.0 alpha: 1.0];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    }
    
    // If it is the wallet address row, shrink the font size so it will actually fit
    //   And add function to generate Bitcoin Address QR Code
    if (indexPath.row == 5) {
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        cell.detailTextLabel.text = @"Double Tap For QR Code";
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:8.0];
        cell.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeQRAlert:)];
        [tap setNumberOfTapsRequired:2];
        [cell.contentView addGestureRecognizer:tap];
    }
    
    // If the cell is showing a BTC amount, show the USD value as a subtitle
    if (indexPath.row == 7 || indexPath.row == 9 || indexPath.row == 11 || indexPath.row == 13 || indexPath.row == 15) {
        // If Bitstamp data is available
        if (bd != nil) {
            cell.detailTextLabel.text = [Utilities btcToUsd:bd value:[tableData objectAtIndex:indexPath.row]];
        }
    }
    
    return cell;
}

// Function to create and display a QR code of wallet address
- (IBAction)makeQRAlert:(id)sender{
    // Create frame for ImageView
    UIImageView *qrcodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,300,300)];
    // Create BTC link
    NSMutableString *linkString = [@"bitcoin:" mutableCopy];
    [linkString appendString:tableData[5]];
    // Create QR Image
    qrcodeImageView.image = [UIImage QRCodeGenerator:linkString
                                      andLightColour:[UIColor whiteColor]
                                       andDarkColour:[UIColor blackColor]
                                        andQuietZone:1
                                             andSize:300];
    // Create alert view
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    [alertView setContainerView:qrcodeImageView];
    [alertView setButtonTitles:[NSArray arrayWithObjects: @"Done",nil]];
    // Display alert view
    [alertView show];
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
