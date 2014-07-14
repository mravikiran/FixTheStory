//
//  StoryXMLParser.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/9/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Level.h"
#import "Story.h"

@interface StoryXMLParser : NSXMLParser <NSXMLParserDelegate>




@property ( atomic, strong) NSMutableDictionary * storiesbyLevel;
@property ( atomic, strong) NSMutableArray * stories;
@property ( atomic, strong) NSMutableArray * easyStories;
@property ( atomic, strong) NSMutableArray * mediumStories;
@property (atomic) Level * currentLevel;
@property (atomic) Story * currentStory;
@property (atomic) NSString * currentImage;
@property (atomic) NSMutableString * element;



-(void) setup;

-(Story*) getStoryNumber:(NSInteger)storyNum fromLevel:(NSInteger)levelNum;
-(NSArray*) getStoriesFromLevel:(NSInteger)level;// change the interface to the object Level instead of NSInteger Level
-(NSInteger) getNumberOfLevels;

@end
