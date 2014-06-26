//
//  Level.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/23/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "Level.h"

@implementation Level


- (id) init
{
    self = [super init];
    if (self) {
        //custom initialization
    }
    
    return self;
}

-(id) initWithNumber:(NSInteger) num
{
    self=[super init];
    if(self){
        self.number = num;
    }
    return self;
}

-(id) copyWithZone:(NSZone *)zone {
    
    Level * newLevel = [[[self class] allocWithZone:zone] init];
    if(newLevel){
        newLevel.number = self.number;
    }
    return newLevel;
}


@end
