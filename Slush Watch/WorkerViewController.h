//
//  WorkerViewController.h
//  Foreman
//
//  Created by Zac Lovoy on 11/17/13.
//  Copyright (c) 2013 Zozworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkerViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
