//
//  StoryParser.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 12/18/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Story.h"
#import "Level.h"

@interface StoryParser : NSObject

@property (atomic) NSMutableDictionary* storiesByLevel;

-(Story*) GetStoryByLevel:(Level*)level Id:(NSInteger)storyId;
-(void) LoadStoriesFromUrl:(NSString*)dataPath;
-(NSInteger) GetNumberOfLevels;
-(void) Setup;
-(Story*) GetStoryNumber:(NSInteger)storyNum FromLevel:(NSInteger)levelNum;
-(NSArray*) GetStoriesFromLevel:(NSInteger)level;// change the interface to the object Level instead of NSInteger Level

@end
