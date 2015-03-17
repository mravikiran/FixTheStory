//
//  StoryJSONParser.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 12/20/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "StoryParser.h"

@interface StoryJSONParser : StoryParser <NSURLConnectionDataDelegate>
-(void) SetTags:(Story*) story GivenDictionary:(NSDictionary*)storyDictionary;
-(Story*) MakeStory:(NSDictionary*)storyDictionary;


@end
