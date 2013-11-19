//
//  Worker.h
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zozworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Worker : NSObject

@property NSString* name;
@property NSString* alive;
@property NSString* hashrate;
@property NSString* lastShare;
@property NSString* score;
@property NSString* shares;

-(NSComparisonResult)compare:(Worker *)otherObject;

@end
