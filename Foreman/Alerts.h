//
//  Alerts.h
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zac lovoy. All rights reserved.
//
//  Class to run alerts and warnings

#import <Foundation/Foundation.h>

@interface Alerts : NSObject

// Function for an alert if the API Key is bad
+(void)badKeyAlert;
// Function for an alert when the API Key is saved
+(void)saveKey;
// Function for an alert with legal details
+(void)aboutAlert;

@end
