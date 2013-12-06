//
//  Json.m
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zac Lovoy. All rights reserved.
//
//  Class to run Json functions to call the server for data

#import "Json.h"
#import "UserData.h"
#import "Worker.h"
#import "BitstampData.h"

@implementation Json

// Function to send a JSON command to the server and return the raw data (GET)
+(NSMutableData*)sendJsonCommandToData:(NSMutableString*)cmd{
    NSURL *URL = [NSURL URLWithString:[cmd stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableData *data = [NSData dataWithContentsOfURL:URL];
    return data;
}

// Function to get the UserData for a user given an API key
+(UserData*)getUserData:(NSString*)key {
    UserData* user = [[UserData alloc]init];
    // Start building the command
    NSMutableString *command = [[NSMutableString alloc] init];
    // Set URL
    [command appendString:@"https://mining.bitcoin.cz/accounts/profile/json/"];
    // Set Key
    [command appendString:key];
    // Run json command
    NSMutableData *resultData = [self sendJsonCommandToData:command];
    
    // Decode result
    NSError *e = nil;
    NSMutableDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error: &e];
    // Try if data return is proper
    @try {
        // Get UserData from returned data
        user.rating = [jsonArray valueForKey:@"rating"];
        user.hashrate = [jsonArray valueForKey:@"hashrate"];
        user.wallet = [jsonArray valueForKey:@"wallet"];
        user.unconfirmedReward = [jsonArray valueForKey:@"unconfirmed_reward"];
        user.confirmedReward = [jsonArray valueForKey:@"confirmed_reward"];
        user.username = [jsonArray valueForKey:@"username"];
        user.sendThreshold = [jsonArray valueForKey:@"send_threshold"];
        user.estimatedReward = [jsonArray valueForKey:@"estimated_reward"];
        
        // Try if the Worker data is correct
        @try {
            // Extract worker data
            NSMutableDictionary *work = [jsonArray valueForKey:@"workers"];
            NSArray *keys = [work allKeys];
            NSMutableArray *workerArray = [[NSMutableArray alloc] initWithCapacity:[keys count]];
            // For each worker build a Worker object
            for (NSInteger x = 0; x < [keys count]; x++) {
                NSMutableArray *wkrs = [work objectForKey:[keys objectAtIndex:x]];
                Worker *wkr = [[Worker alloc]init];
                wkr.name = [keys objectAtIndex:x];
                wkr.alive = [[wkrs valueForKey:@"alive"] stringValue];
                wkr.hashrate = [[wkrs valueForKey:@"hashrate"] stringValue];
                // Translate the date from Unix time to a human readable date and time
                NSTimeInterval te = [[wkrs valueForKey:@"last_share"] doubleValue];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:te];
                NSDateFormatter* formatter= [NSDateFormatter new];
                [formatter setDateFormat:@"MMM dd, yyyy HH:mm"];
                NSString* formattedDate= [formatter stringFromDate: date];
                wkr.lastShare = formattedDate;
                wkr.score = [wkrs valueForKey:@"score"];
                wkr.shares = [[wkrs valueForKey:@"shares"] stringValue];
                workerArray[x] = wkr;
            }
            // Add the worker array to the UserData object
            user.workerArray = workerArray;
        }
        // If the data is bad return an error message
        @catch (NSException *f) {
            user.workerArray = [NSMutableArray arrayWithObjects:@"No Data Found", nil];
        }
    }
    // Set the UserData to nil if the data returned is bad
    @catch (NSException *e) {
        user = nil;
    }
    // Return the user object
    return user;
}

// Function to get the current Bitcoin Price data from Bitstamp
+(BitstampData*)getBitstampData {
    BitstampData *bd = [[BitstampData alloc]init];
    // Start building the command
    NSMutableString *command = [[NSMutableString alloc] init];
    // Set URL
    [command appendString:@"https://www.bitstamp.net/api/ticker/"];
    // Run json command
    NSMutableData *resultData = [self sendJsonCommandToData:command];
    
    // Decode result
    NSError *e = nil;
    NSMutableDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error: &e];
    
    // Try to decode result
    @try {
        bd.volume = [jsonArray valueForKey:@"volume"];
        bd.high = [jsonArray valueForKey:@"high"];
        bd.last = [jsonArray valueForKey:@"last"];
        bd.ask = [jsonArray valueForKey:@"ask"];
        bd.bid = [jsonArray valueForKey:@"bid"];
        bd.timestamp = [jsonArray valueForKey:@"timestamp"];
        bd.low = [jsonArray valueForKey:@"low"];
    }
    // If bad data, set return data to nil
    @catch (NSException *e) {
        bd = nil;
    }
    // Return Bitstamp Data
    return bd;
}
@end
