//
//  BitstampData.m
//  Foreman
//
//  Created by Zac Lovoy on 12/5/13.
//  Copyright (c) 2013 Zac Lovoy. All rights reserved.
//
//  Model class to hold Bitcoin pricing information from Bitstamp

#import "BitstampData.h"

@implementation BitstampData

// Members
// Holds the high price for 1 BTC in the last 24 hours
@synthesize high;
// Holds the last price 1 BTC went for
@synthesize last;
// Timestamp when the call was made
@synthesize timestamp;
// Highest bid order for 1 BTC
@synthesize bid;
// Last 24 hour volume
@synthesize volume;
// Lowest price for 1 BTC in the last 24 hours
@synthesize low;
// Lowest Sell price for 1 BTC currently
@synthesize ask;

@end
