//
//  Utilities.h
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zozworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserData.h"

@interface Utilities : NSObject

+ (NSString *) saveFilePath;
+(void)saveKey:(NSString*)key;
+(NSString*)retrieveKey;
+(NSMutableArray*)convertWorkerArrayToTableArray:(NSArray*)workerArray;
+(NSMutableArray*)convertUserDataToTableArray:(UserData*)data;
+(NSMutableArray*)convertUserDataToTableArray2:(UserData*)data;

@end
