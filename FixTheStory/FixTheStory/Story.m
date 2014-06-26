//
//  Story.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/10/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "Story.h"

@implementation Story

- (id) init
{
    self = [super init];
    if (self) {
        //custom initialization
        self.partsOfStory = [[NSMutableArray alloc] init];
    }

    return self;
}


- (void) addPartOfStory:(NSString*)part
{
    //if([part length] != 0)
        [self.partsOfStory addObject:part];
}

@end
