//
//  FixedStoriesCounter.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/28/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FixedStoriesCounter : NSObject

@property ( atomic) NSMutableArray * completedStoriesByLevel;

-(id) initWithNumberOfLevels:(NSInteger)numberOfLevels;
- (void) updateCompletedStoriesByLevelArray:(NSArray*) newArray;
- (NSInteger) getNumberOfLevels;
- (NSInteger) lastCompletedStoryForLevel:(NSInteger)level; //use Level instead of NSInteger


@end
