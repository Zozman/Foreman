//
//  Json.h
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zac Lovoy. All rights reserved.
//
//  Class to run Json functions to call the server for data

#import <Foundation/Foundation.h>
#import "UserData.h"
#import "BitstampData.h"

@interface Json : NSObject

// Function to get the UserData from the server given an API Key
+(UserData*)getUserData:(NSString*)key;
// Function to get the current Bitcoin Price data from Bitstamp
+(BitstampData*)getBitstampData;

@end
