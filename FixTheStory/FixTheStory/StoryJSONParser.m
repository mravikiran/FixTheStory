//
//  StoryJSONParser.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 12/20/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "StoryJSONParser.h"

@implementation StoryJSONParser


-(id) init
{
    self = [super init];
    [self Setup];
    return self;
}

-(void) SetTags:(Story*) story GivenDictionary:(NSDictionary*)storyDictionary
{
    for (int i =1; i<=story.numberOfImages; i++) {
        NSString *tagN = [NSString stringWithFormat:@"tag%d", i];
        NSString * partOfStory = storyDictionary[tagN];
        [story addPartOfStory:partOfStory];
    }
}

-(Story*) MakeStory:(NSDictionary*)storyDictionary
{
    Story * story = [[Story alloc] init];
    story.actualStory = storyDictionary[@"story"];
    story.numberOfImages =  [storyDictionary[@"story_size"] integerValue];
    story.id = [storyDictionary[@"story_id"] integerValue];
    [self SetTags:story GivenDictionary:storyDictionary];
    return story;
}

-(void) ParseJSONStories:(NSDictionary*) storiesAsJson
{
    NSArray * stories = storiesAsJson[@"stories"];
    for(NSDictionary* storyDictionary in stories)
    {
        Story * story = [self MakeStory:storyDictionary];
        NSNumber * level = [NSNumber numberWithInteger:[storyDictionary[@"level"] integerValue]];
        NSMutableArray * storiesForLevel = [self.storiesByLevel objectForKey:level];
        if (!storiesForLevel)
        {
            storiesForLevel = [[NSMutableArray alloc] init];
        }
        [storiesForLevel addObject:story];
        [self.storiesByLevel setObject:storiesForLevel forKey:level];
    }
    
}

-(void) LoadStoriesFromUrl:(NSString*)dataPath
{
    NSURL* url = [NSURL URLWithString:dataPath];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]  completionHandler:
        ^(NSURLResponse * response , NSData *data, NSError * connectionError)
        {
            NSLog(@"Coming Here inside completion handler");
            if(data.length > 0 && connectionError == nil)
            {
                NSDictionary * stories = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                [self ParseJSONStories:stories];
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"dataFetchComplete" object:nil];
            }
         
        }
    ];

}

-(void) Setup
{
    self.storiesByLevel =[[NSMutableDictionary alloc] init];
    
}

@end
