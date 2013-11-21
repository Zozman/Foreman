//
//  Worker.h
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zac Lovoy. All rights reserved.
//
//  Model class to hold the information about an individual worker

#import <Foundation/Foundation.h>

@interface Worker : NSObject

// Members
// Holds the name of the worker
@property NSString* name;
// Holds if the worker is running or not (0 for no, 1 for yes)
@property NSString* alive;
// Holds the hashrate for the worker
@property NSString* hashrate;
// Holds the date of the last share
@property NSString* lastShare;
// Holds the worker's current score
@property NSString* score;
// Holds the number of shares for the worker
@property NSString* shares;

@end
