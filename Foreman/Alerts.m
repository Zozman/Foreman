//
//  Alerts.m
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zac Lovoy. All rights reserved.
//
//  Class to run alerts and warnings

#import "Alerts.h"

@implementation Alerts

// Function for an alert if the API Key is bad
+(void)badKeyAlert {
    // Build alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bad Key"
                                                    message:@"Your API Key Is Bad.  Please fix it!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    // Show alert
    [alert show];
}

// Function for an alert when the API Key is saved
+(void)saveKey {
    // Build alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Complete"
                                                    message:@"Your API Key has been saved!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    // Show alert
    [alert show];
}

@end
