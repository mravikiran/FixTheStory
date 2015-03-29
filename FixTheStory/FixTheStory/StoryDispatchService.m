//
//  StoryDispatchService.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/27/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "StoryDispatchService.h"

@implementation StoryDispatchService



- (Story*) getNextStoryFromParser:(StoryParser*)storyParser givenFixedStoriesCounter:(FixedStoriesCounter*)fixedStoriesCounter updateLevel:(Level **)level withCurrentLevel:(Level *)currentLevel
{
    if (currentLevel.number > 0)
    {
        for (NSInteger i = currentLevel.number-1; i<[fixedStoriesCounter GetNumberOfLevels]; i++)
        {
            Level *  keyLevel= [[Level alloc] initWithNumber:i];
            NSArray * stories = [storyParser GetStoriesFromLevel:keyLevel];
            NSInteger completedStoryId = [fixedStoriesCounter LastFixedStoryForLevel:keyLevel];
            for(Story *story in stories)
            {
                if(story.id > completedStoryId)
                {
                    (*level).number = keyLevel.number;
                    return story;
                }
            }
        }
    }
    return nil;
}


@end
