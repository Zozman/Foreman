//
//  UserData.h
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zozworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

@property NSString* rating;
@property NSString* hashrate;
@property NSString* wallet;
@property NSString* unconfirmedReward;
@property NSString* confirmedReward;
@property NSString* username;
@property NSString* sendThreshold;
@property NSString* estimatedReward;
@property NSMutableArray* workerArray;

@end
