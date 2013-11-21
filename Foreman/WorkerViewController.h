//
//  WorkerViewController.h
//  Foreman
//
//  Created by Zac Lovoy on 11/17/13.
//  Copyright (c) 2013 Zac Lovoy. All rights reserved.
//
// This class is the view controller for the worker view tab

#import <UIKit/UIKit.h>

@interface WorkerViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
// Main table view in the tab view
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
