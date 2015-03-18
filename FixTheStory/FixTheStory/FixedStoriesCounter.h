//
//  FixedStoriesCounter.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/28/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Story.h"
#import "Level.h"

@interface FixedStoriesCounter : NSObject

@property ( atomic) NSMutableDictionary * completedStoriesByLevel;

-(id) initWithNumberOfLevels:(NSInteger)numberOfLevels;
- (void) UpdateCompletedStoriesByLevelDictionary:(NSMutableDictionary*) newArray;
- (NSInteger) GetNumberOfLevels;
- (NSInteger) LastFixedStoryForLevel:(Level*)level;
- (void) UpdateLastFixedStoryForLevel:(Level*)level ToStory:(Story*) story;


@end
