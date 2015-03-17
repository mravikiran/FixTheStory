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
#import "StoryParser.h"

@interface StoryXMLParser : StoryParser <NSXMLParserDelegate>




//@property ( atomic, strong) NSMutableDictionary * storiesbyLevel;
@property ( atomic, strong) NSMutableArray * stories;
@property ( atomic, strong) NSMutableArray * easyStories;
@property ( atomic, strong) NSMutableArray * mediumStories;
@property (atomic) Level * currentLevel;
@property (atomic) Story * currentStory;
@property (atomic) NSString * currentImage;
@property (atomic) NSMutableString * element;
@property (atomic) NSXMLParser * xmlParser;





@end
