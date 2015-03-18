//
//  StoryDispatchService.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/27/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "StoryDispatchService.h"

@implementation StoryDispatchService



- (Story*) getNextStoryFromParser:(StoryParser*)storyParser givenFixedStoriesCounter:(FixedStoriesCounter*)fixedStoriesCounter updateLevel:(Level **)level
{
    NSInteger numberOfLevels = [storyParser GetNumberOfLevels];
    NSArray * allLevels = [storyParser GetAllLevels];
    for (Level* keyLevel in allLevels) {
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
    
    return nil;
}


@end
