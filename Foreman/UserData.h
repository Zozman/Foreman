//
//  UserData.h
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zac Lovoy. All rights reserved.
//
//  This class is a model class to hold User Data returned from the server

#import <Foundation/Foundation.h>

@interface UserData : NSObject
// Members
// Holds the rating
@property NSString* rating;
// Holds the total hashrate
@property NSString* hashrate;
// Holds the saved wallet address
@property NSString* wallet;
// Holds the amount of unconfirmed reward
@property NSString* unconfirmedReward;
// Holds the amount of confirmed reward
@property NSString* confirmedReward;
// Holds the username
@property NSString* username;
// Holds the send threshold amount
@property NSString* sendThreshold;
// Holds the estimated reward
@property NSString* estimatedReward;
// Holds an array of Worker objects that contain data of each worker assigned to the account
@property NSMutableArray* workerArray;

@end
