//
//  Json.m
//  Slush Watch
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zozworks. All rights reserved.
//

#import "Json.h"
#import "UserData.h"
#import "Worker.h"

@implementation Json

+(NSMutableData*)sendJsonCommandToData:(NSMutableString*)cmd{
    NSURL *URL = [NSURL URLWithString:[cmd stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableData *data = [NSData dataWithContentsOfURL:URL];
    return data;
}

+(UserData*)getUserData:(NSString*)key {
    UserData* user = [[UserData alloc]init];
    NSMutableString *command = [[NSMutableString alloc] init];
    [command appendString:@"https://mining.bitcoin.cz/accounts/profile/json/"];
    [command appendString:key];
    // Run json command
    NSMutableData *resultData = [self sendJsonCommandToData:command];
    
    // Decode result
    NSError *e = nil;
    NSMutableDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error: &e];
    @try {
        user.rating = [jsonArray valueForKey:@"rating"];
        user.hashrate = [jsonArray valueForKey:@"hashrate"];
        user.wallet = [jsonArray valueForKey:@"wallet"];
        user.unconfirmedReward = [jsonArray valueForKey:@"unconfirmed_reward"];
        user.confirmedReward = [jsonArray valueForKey:@"confirmed_reward"];
        user.username = [jsonArray valueForKey:@"username"];
        user.sendThreshold = [jsonArray valueForKey:@"send_threshold"];
        user.estimatedReward = [jsonArray valueForKey:@"estimated_reward"];
        
        @try {
            NSMutableDictionary *work = [jsonArray valueForKey:@"workers"];
            NSArray *keys = [work allKeys];
            NSMutableArray *workerArray = [[NSMutableArray alloc] initWithCapacity:[keys count]];
            for (NSInteger x = 0; x < [keys count]; x++) {
                NSMutableArray *wkrs = [work objectForKey:[keys objectAtIndex:x]];
                Worker *wkr = [[Worker alloc]init];
                wkr.name = [keys objectAtIndex:x];
                wkr.alive = [[wkrs valueForKey:@"alive"] stringValue];
                wkr.hashrate = [[wkrs valueForKey:@"hashrate"] stringValue];
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
            user.workerArray = workerArray;
        }
        @catch (NSException *f) {
            user.workerArray = [NSMutableArray arrayWithObjects:@"No Data Found", nil];
        }
        
    }
    @catch (NSException *e) {
        user = nil;
    }
    return user;
}

@end
