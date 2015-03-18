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
        self.completedStoriesByLevel = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(id) initWithNumberOfLevels:(NSInteger)numberOfLevels
{
    
    self = [super init];
    if(self){
        self.completedStoriesByLevel = [[NSMutableDictionary alloc] init];
        for (int i=0; i<numberOfLevels; i++) {
            [self.completedStoriesByLevel setObject:[NSNumber numberWithInteger:0] forKey:[[Level alloc] initWithNumber:(i+1)]];
        }
    }
    return self;
    
}

- (void) UpdateCompletedStoriesByLevelDictionary:(NSMutableDictionary*) newArray{
    [self.completedStoriesByLevel removeAllObjects];
    self.completedStoriesByLevel = newArray;
    
}

- ( NSInteger) GetNumberOfLevels {
    return [self.completedStoriesByLevel count];
}

- (Level*)GetEquivalentLevelInMap:(Level*)level {
    for(Level * levelKey in [self.completedStoriesByLevel allKeys])
    {
        if (levelKey.number == level.number) {
            return levelKey;
        }
    }
    return nil;
}

- (NSInteger) LastFixedStoryForLevel:(Level*)level
{
    Level* levelInMap = [self GetEquivalentLevelInMap:level];
    if(levelInMap)
    {
        return [self.completedStoriesByLevel[levelInMap] integerValue];
    }
    else
    {
        return 0;
    }
}

- (void) UpdateLastFixedStoryForLevel:(Level*)level ToStory:(Story*) story
{
    Level* levelInMap = [self GetEquivalentLevelInMap:level];
    if (levelInMap) {
        NSInteger storyId = story? story.id : 0;
        self.completedStoriesByLevel[levelInMap] = [NSNumber numberWithInteger:storyId];
    }
}





@end
