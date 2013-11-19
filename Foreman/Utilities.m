//
//  Utilities.m
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zozworks. All rights reserved.
//

#import "Utilities.h"
#import "UserData.h"
#import "Worker.h"

@implementation Utilities

+ (NSString *) saveFilePath
{
	NSArray *path =
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
	return [[path objectAtIndex:0] stringByAppendingPathComponent:@"savefile.plist"];
    
}

+(void)saveKey:(NSString*)key {
    NSArray *values = [[NSArray alloc] initWithObjects:key,nil];
    [values writeToFile:[self saveFilePath] atomically:YES];
}

+(NSString*)retrieveKey {
    NSString* key = [[NSString alloc]init];
    key = @"";
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[Utilities saveFilePath]];
	if (fileExists)
	{
		NSArray *values = [[NSArray alloc] initWithContentsOfFile:[Utilities saveFilePath]];
		key = [values objectAtIndex:0];
	}
    return key;
}

+(NSMutableArray*)convertWorkerArrayToTableArray:(NSArray*)workerArray {
    NSMutableArray *output = [[NSMutableArray alloc] initWithCapacity:[workerArray count]*6];
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

+(NSMutableArray*)convertUserDataToTableArray:(UserData*)data {
    NSMutableArray *output = [[NSMutableArray alloc] initWithCapacity:8];
    NSMutableString *temp = [@"Username: " mutableCopy];
    [temp appendString:data.username];
    output[0] = temp;
    temp = [@"Hashrate: " mutableCopy];
    [temp appendString:data.hashrate];
    output[1] = temp;
    temp = [@"Wallet Address: " mutableCopy];
    [temp appendString:data.wallet];
    output[2] = temp;
    temp = [@"Send Threshold: " mutableCopy];
    [temp appendString:data.sendThreshold];
    [temp appendString:@" BTC"];
    output[3] = temp;
    temp = [@"Estimated Reward: " mutableCopy];
    [temp appendString:data.estimatedReward];
    [temp appendString:@" BTC"];
    output[4] = temp;
    temp = [@"Uncomfirmed Reward: " mutableCopy];
    [temp appendString:data.unconfirmedReward];
    [temp appendString:@" BTC"];
    output[5] = temp;
    temp = [@"Confirmed Reward: " mutableCopy];
    [temp appendString:data.confirmedReward];
    [temp appendString:@" BTC"];
    output[6] = temp;
    temp = [@"Total Reward: " mutableCopy];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *unconf = [f numberFromString:data.unconfirmedReward];
    NSNumber *conf = [f numberFromString:data.confirmedReward];
    NSNumber *sum = [NSNumber numberWithFloat:([unconf floatValue] + [conf floatValue])];
    [temp appendString:[sum stringValue]];
    [temp appendString:@" BTC"];
    output[7] = temp;
    
    return output;
}

+(NSMutableArray*)convertUserDataToTableArray2:(UserData*)data {
    NSMutableArray *output = [[NSMutableArray alloc] initWithCapacity:16];
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

@end
