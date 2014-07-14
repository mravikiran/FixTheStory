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
- (void) updateCompletedStoriesByLevelArray:(NSArray*) newArray;
- (NSInteger) getNumberOfLevels;
- (NSInteger) lastFixedStoryForLevel:(Level*)level; //use Level instead of NSInteger

- (void) updateLastFixedStoryForLevel:(Level*)level toStory:(Story*) story; //use Level instead of NSInteger


@end
