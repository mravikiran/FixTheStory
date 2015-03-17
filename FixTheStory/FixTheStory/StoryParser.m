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
    
    //dummy base class implementations
    //needs to be overridden by the concrete classes

    return 0;
}
-(void) Setup
{
    
    //dummy base class implementations
    //needs to be overridden by the concrete classes

}
-(Story*) GetStoryNumber:(NSInteger)storyNum FromLevel:(NSInteger)levelNum
{
    
    //dummy base class implementations
    //needs to be overridden by the concrete classes
    return NULL;

}
-(NSArray*) GetStoriesFromLevel:(NSInteger)level
{
    
    //dummy base class implementations
    //needs to be overridden by the concrete classes
    return NULL;

}

@end
