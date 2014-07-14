//
//  FixedStoriesCounter.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/28/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "FixedStoriesCounter.h"

@implementation FixedStoriesCounter

-(id) init{
    self = [super init];
    if(self){
        self.completedStoriesByLevel = [[NSMutableArray alloc] init];
    }
    return self;
}
-(id) initWithNumberOfLevels:(NSInteger)numberOfLevels
{
    
    self = [super init];
    if(self){
        self.completedStoriesByLevel = [[NSMutableArray alloc] init];
        for (int i=0; i<numberOfLevels; i++) {
            [self.completedStoriesByLevel addObject:(NSInteger)0];
        }
    }
    return self;
    
}

- (void) updateCompletedStoriesByLevelArray:(NSArray*) newArray{
    [self.completedStoriesByLevel removeAllObjects];
    
    for( id object in newArray){
        [self.completedStoriesByLevel addObject:object];
    }
    
    
}

- ( NSInteger) getNumberOfLevels {
    return [self.completedStoriesByLevel count];
}

- (NSInteger) lastFixedStoryForLevel:(Level*)level {
    return [self.completedStoriesByLevel[level.number-1] integerValue];
}

- (void) updateLastFixedStoryForLevel:(Level*)level toStory:(Story*) story{
 
    if ([self.completedStoriesByLevel count] >= level.number) {
        self.completedStoriesByLevel[level.number-1] = [NSNumber numberWithInteger:story.id];
    }
}





@end