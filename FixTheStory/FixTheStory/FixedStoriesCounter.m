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
        for (int i=0; i<numberOfLevels; i++)
        {
            [self.completedStoriesByLevel addObject:[NSNumber numberWithInteger:(NSInteger)0]];
        }
    }
    return self;
    
}

- (void) UpdateCompletedStoriesByLevelDictionary:(NSMutableArray*) newArray{
    [self.completedStoriesByLevel removeAllObjects];
    self.completedStoriesByLevel = newArray;
    
}

- ( NSInteger) GetNumberOfLevels {
    return [self.completedStoriesByLevel count];
}

- (NSInteger) LastFixedStoryForLevel:(Level*)level
{
    if(level.number != 0)
    {
        return  [[self.completedStoriesByLevel objectAtIndex:level.number-1] integerValue];
    }
    else
    {
        return 0;
    }
}

- (void) UpdateLastFixedStoryForLevel:(Level*)level ToStory:(Story*) story
{
    if (level.number != 0) {
        NSInteger storyId = story? story.id : 0;
        [self.completedStoriesByLevel insertObject:[NSNumber numberWithInteger:storyId] atIndex:(level.number-1)];
    }
}





@end
