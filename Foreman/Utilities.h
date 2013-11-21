//
//  Utilities.h
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zac Lovoy. All rights reserved.
//
//  Class that holds miscellaneous utility functions

#import <Foundation/Foundation.h>
#import "UserData.h"

@interface Utilities : NSObject

// Function to get the location of the save file
+ (NSString *) saveFilePath;
// Function to save the API Key
+(void)saveKey:(NSString*)key;
// Function to retrieve the API Key
+(NSString*)retrieveKey;
// Function to convert the array of Workers to an Array that can be inserted into a table view
+(NSMutableArray*)convertWorkerArrayToTableArray:(NSArray*)workerArray;
// Function to convert UserData to an Array that can be inserted into a table view
+(NSMutableArray*)convertUserDataToTableArray:(UserData*)data;

@end
