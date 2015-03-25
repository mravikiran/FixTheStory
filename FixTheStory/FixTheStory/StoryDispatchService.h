//
//  StoryDispatchService.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/27/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoryParser.h"
#import "Story.h"
#import "Level.h"
#import "FixedStoriesCounter.h"
@interface StoryDispatchService : NSObject


- (Story*) getNextStoryFromParser:(StoryParser*)storyXMLParser givenFixedStoriesCounter:(FixedStoriesCounter*)fixedStoriesCounters updateLevel:(Level**)level withCurrentLevel:(Level*)currentLevel;


@end
