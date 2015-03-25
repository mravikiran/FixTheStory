//
//  StoryParser.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 12/18/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "StoryParser.h"

@implementation StoryParser


-(Story*) GetStoryByLevel:(Level*)level Id:(NSInteger)storyId
{
    //dummy implementation
    return NULL;
}
-(void) LoadStoriesFromUrl:(NSString*)dataPath
{
   //dummy base class implementations
    //needs to be overridden by the concrete classes
}
-(NSInteger) GetNumberOfLevels
{
    return [self.storiesByLevel count];

}
-(void) Setup
{
    
    //dummy base class implementations
    //needs to be overridden by the concrete classes

}

-(Story*) GetStoryNumber:(NSInteger)storyNum FromLevel:(NSInteger)levelNum
{
    NSArray * stories;
    for(NSNumber *key in self.storiesByLevel)
    {
        if ([key integerValue] == levelNum) {
            
            stories = self.storiesByLevel[key];
            break;
        }
    }
    if ([stories count] < storyNum) {
        storyNum = [stories count];
    }
    return stories[storyNum-1]; // presently its not returning any null value
    
}

-(NSArray*) GetAllLevels
{
    return [self.storiesByLevel allKeys];
}

-(NSArray*) GetStoriesFromLevel:(Level*)level { // change the interface to the object Level
    
    for (NSNumber * key  in [self.storiesByLevel allKeys]) {
        if ([key integerValue] == level.number) {
            return self.storiesByLevel[key];
        }
    }
    return nil;
}

@end
