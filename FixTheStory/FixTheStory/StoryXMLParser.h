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

@property (atomic) Level * currentLevel;
@property (atomic) Story * currentStory;
@property (atomic) NSString * currentImage;


@property (atomic) NSMutableString * element;
@end
