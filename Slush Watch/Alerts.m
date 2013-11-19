//
//  Alerts.m
//  Slush Watch
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zozworks. All rights reserved.
//

#import "Alerts.h"

@implementation Alerts

+(void)badKeyAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bad Key"
                                                    message:@"Your API Key Is Bad.  Please fix it!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

+(void)saveKey {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Complete"
                                                    message:@"Your API Key has been saved!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
