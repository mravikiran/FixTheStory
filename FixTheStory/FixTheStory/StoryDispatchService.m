//
//  StoryDispatchService.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/27/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "StoryDispatchService.h"

@implementation StoryDispatchService



- (Story*) getNextStoryFromParser:(StoryXMLParser*)storyXMLParser givenFixedStoriesCounter:(FixedStoriesCounter*)fixedStoriesCounter
{
    NSInteger numberOfLevels = [fixedStoriesCounter getNumberOfLevels];
    
    for (NSInteger i=1; i<numberOfLevels; i++) {
        NSArray * stories = [storyXMLParser getStoriesFromLevel:i];
        NSInteger completedStoryId = [fixedStoriesCounter lastCompletedStoryForLevel:i];
        for(Story *story in stories)
        {
            if(story.id > completedStoryId)
                return story;
        }
    }
    
    return nil;
}


@end
