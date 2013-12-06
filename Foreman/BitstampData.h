//
//  BitstampData.h
//  Foreman
//
//  Created by Zac Lovoy on 12/5/13.
//  Copyright (c) 2013 Zac Lovoy. All rights reserved.
//
//  Model class to hold Bitcoin pricing information from Bitstamp

#import <Foundation/Foundation.h>

@interface BitstampData : NSObject

// Members
// Holds the high price for 1 BTC in the last 24 hours
@property NSString* high;
// Holds the last price 1 BTC went for
@property NSString* last;
// Timestamp when the call was made
@property NSString* timestamp;
// Highest bid order for 1 BTC
@property NSString* bid;
// Last 24 hour volume
@property NSString* volume;
// Lowest price for 1 BTC in the last 24 hours
@property NSString* low;
// Lowest Sell price for 1 BTC currently
@property NSString* ask;

@end
