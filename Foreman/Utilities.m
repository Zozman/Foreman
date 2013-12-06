//
//  Utilities.m
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zac Lovoy. All rights reserved.
//
//  Class that holds miscellaneous utility functions

#import "Utilities.h"
#import "UserData.h"
#import "Worker.h"
#import "BitstampData.h"

@implementation Utilities

// Function to get the location of the save file
+ (NSString *) saveFilePath
{
    // Get file path
	NSArray *path =
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // Return file path
	return [[path objectAtIndex:0] stringByAppendingPathComponent:@"savefile.plist"];
    
}

// Function to save the API Key
+(void)saveKey:(NSString*)key {
    // Create array to save data
    NSArray *values = [[NSArray alloc] initWithObjects:key,nil];
    // Save data to save file
    [values writeToFile:[self saveFilePath] atomically:YES];
}

// Function to retrieve the API Key
+(NSString*)retrieveKey {
    NSString* key = [[NSString alloc]init];
    key = @"";
    // Test if the save file exists
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[Utilities saveFilePath]];
    //If the file exists, retrieve the saved key from the save file
	if (fileExists)
	{
		NSArray *values = [[NSArray alloc] initWithContentsOfFile:[Utilities saveFilePath]];
		key = [values objectAtIndex:0];
	}
    return key;
}

// Function to convert the array of Workers to an Array that can be inserted into a table view
+(NSMutableArray*)convertWorkerArrayToTableArray:(NSArray*)workerArray {
    NSMutableArray *output = [[NSMutableArray alloc] initWithCapacity:[workerArray count]*6];
    // For each worker in the array, make rows with labels and data
    for (NSInteger x = 0, y = 0; x < [workerArray count]; x++, y += 6) {
        Worker *wkr = workerArray[x];
        NSMutableString *temp = [@"Name: " mutableCopy];
        [temp appendString:wkr.name];
        output[y] = temp;
        if ([wkr.alive  isEqual: @"1"]) {
            temp = [@"Working" mutableCopy];
        } else {
            temp = [@"Not Working" mutableCopy];
        }
        output[y+1] = temp;
        temp = [@"Hashrate (Mhash/s): " mutableCopy];
        [temp appendString:wkr.hashrate];
        output[y+2] = temp;
        temp = [@"Last Share: " mutableCopy];
        [temp appendString:wkr.lastShare];
        output[y+3] = temp;
        temp = [@"Score: " mutableCopy];
        [temp appendString:wkr.score];
        output[y+4] = temp;
        temp = [@"Shares In Current Round: " mutableCopy];
        [temp appendString:wkr.shares];
        output[y+5] = temp;
    }
    return output;
}

// Function to convert UserData to an Array that can be inserted into a table view
+(NSMutableArray*)convertUserDataToTableArray:(UserData*)data {
    NSMutableArray *output = [[NSMutableArray alloc] initWithCapacity:16];
    // Create alternating rows in array of labels and data
    output[0] = @"Username";
    output[1] = data.username;
    output[2] = @"Hashrate (Last 10 Rounds MH/s)";
    output[3] = data.hashrate;
    output[4] = @"Wallet Address";
    output[5] = data.wallet;
    output[6] = @"Send Threshold";
    NSMutableString *temp = [data.sendThreshold mutableCopy];
    [temp appendString:@" BTC"];
    output[7] = temp;
    output[8] = @"Estimated Reward";
    temp = [data.estimatedReward mutableCopy];
    [temp appendString:@" BTC"];
    output[9] = temp;
    output[10] = @"Uncomfirmed Reward";
    temp = [data.unconfirmedReward mutableCopy];
    [temp appendString:@" BTC"];
    output[11] = temp;
    output[12] = @"Confirmed Reward";
    temp = [data.confirmedReward mutableCopy];
    [temp appendString:@" BTC"];
    output[13] = temp;
    output[14] = @"Total Reward";
    // Add up the unconfirmed and confirmed reward to get the total reward
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *unconf = [f numberFromString:data.unconfirmedReward];
    NSNumber *conf = [f numberFromString:data.confirmedReward];
    NSNumber *sum = [NSNumber numberWithFloat:([unconf floatValue] + [conf floatValue])];
    temp = [[sum stringValue] mutableCopy];
    [temp appendString:@" BTC"];
    output[15] = temp;
    
    return output;
}

// Function to convert a BTC value to USD
+(NSMutableString*)btcToUsd:(BitstampData*)data value:(NSString*)value {
    // Create answer string
    NSMutableString *answer = [@"$" mutableCopy];
    // Extract the BTC value from the string
    NSString *btcString = [value substringToIndex:[value length] - 4];
    // Calculate the USD value
    double solutionDouble = [btcString doubleValue] * [data.last doubleValue];
    // Format the value correctly
    NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
    // Set to a decimal
    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    // Round the value
    [format setRoundingMode:NSNumberFormatterRoundHalfUp];
    // 2 Decimal points
    [format setMaximumFractionDigits:2];
    [format setMinimumFractionDigits:2];
    // Add answer to mutable string
    [answer appendString:[[format stringFromNumber:[NSNumber numberWithFloat:solutionDouble]] mutableCopy]];
    // Add 'USD' to the answer
    [answer appendString:@" USD"];
    // Return the string
    return answer;
}

@end
