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

@property ( atomic) NSMutableArray * completedStoriesByLevel;

-(id) initWithNumberOfLevels:(NSInteger)numberOfLevels;
- (void) UpdateCompletedStoriesByLevelArray:(NSArray*) newArray;
- (NSInteger) GetNumberOfLevels;
- (NSInteger) LastFixedStoryForLevel:(Level*)level; //use Level instead of NSInteger

- (void) UpdateLastFixedStoryForLevel:(Level*)level ToStory:(Story*) story; //use Level instead of NSInteger


@end
