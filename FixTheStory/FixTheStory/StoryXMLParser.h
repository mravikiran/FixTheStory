//
//  StoryXMLParser.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/9/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryXMLParser : NSXMLParser <NSXMLParserDelegate>

@property ( atomic, strong) NSDictionary * stories;


@end
