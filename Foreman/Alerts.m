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

// Function for an alert with legal details
+(void)aboutAlert {
    // Build alert
    NSMutableString *details = [@"Note: This app is only for use with the mining.bitcoin.cz pool (for now anyway).  This app is merely a tool to access APIs owned by the pool and claims no ownership over these API's nor responsibility.  Utilizes Custom iOS 7 AlertView (https://github.com/wimagguc/ios-custom-alertview) and QR Code Implementation by Oscar Sanderson (http://www.oscarsanderson.com/2013/08/12/implementing-a-qr-code-generator-on-the-iphone) and libqrencode (http://fukuchi.org/works/qrencode/index.html.en)" mutableCopy];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"About"
                                                    message:details
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    // Show alert
    [alert show];
}

@end
