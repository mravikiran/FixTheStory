//
//  StoryDispatchService.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/27/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoryXMLParser.h"
#import "Story.h"
#import "Level.h"
#import "FixedStoriesCounter.h"
@interface StoryDispatchService : NSObject


- (Story*) getNextStoryFromParser:(StoryXMLParser*)storyXMLParser givenFixedStoriesCounter:(FixedStoriesCounter*)fixedStoriesCounters updateLevel:(Level**)level;


@end
