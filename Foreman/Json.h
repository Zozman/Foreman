//
//  Json.h
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zozworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserData.h"

@interface Json : NSObject

+(UserData*)getUserData:(NSString*)key;

@end
