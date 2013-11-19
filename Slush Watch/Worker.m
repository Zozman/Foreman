//
//  Worker.m
//  Slush Watch
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zozworks. All rights reserved.
//

#import "Worker.h"

@implementation Worker

@synthesize name;
@synthesize alive;
@synthesize hashrate;
@synthesize lastShare;
@synthesize score;
@synthesize shares;

-(NSComparisonResult)compare:(Worker *)otherObject {
    return [self.name compare:otherObject.name];
}

@end
