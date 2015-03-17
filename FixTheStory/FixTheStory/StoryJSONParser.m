//
//  StoryJSONParser.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 12/20/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "StoryJSONParser.h"

@implementation StoryJSONParser



-(Story*) GetStoryByLevel:(Level*)level Id:(NSInteger)storyId
{
    //dummy implementation
    return NULL;
}

-(id) init
{
    self = [super init];
    [self Setup];
    return self;
}

-(Level*) findLevel:(NSInteger)levelNum
{
    Level * returnLevel = nil;
    for (Level* level in [self.storiesByLevel allKeys]) {
        if (level.number == levelNum) {
            return level;
        }
    }
    returnLevel = [[Level alloc] initWithNumber:levelNum];
    return returnLevel;
}

-(void) SetTags:(Story*) story GivenDictionary:(NSDictionary*)storyDictionary
{
    for (int i =1; i<=6; i++) {
        NSString *tagN = [NSString stringWithFormat:@"tag%d", i];
        NSString * partOfStory = storyDictionary[tagN];
        if (![partOfStory isEqual:@".DS_Store"]) {
            [story addPartOfStory:partOfStory];
        }
        else
        {
            [story addPartOfStory:@""];
        }
    }
}

-(Story*) MakeStory:(NSDictionary*)storyDictionary
{
    Story * story = [[Story alloc] init];
    story.actualStory = storyDictionary[@"story"];
    story.numberOfImages =  [storyDictionary[@"story_size"] integerValue];
    story.id = [storyDictionary[@"story_d"] integerValue];
    
    return story;
}

-(void) ParseJSONStories:(NSDictionary*) storiesAsJson
{
    NSArray * stories = storiesAsJson[@"stories"];
    for(NSDictionary* storyDictionary in stories)
    {
//        NSDictionary * storyWithKeys = [NSJSONSerialization JSONObjectWithData:story options:0 error:NULL];
        NSLog([NSString stringWithFormat:@"Number of fields %lu", (unsigned long)[storyDictionary count]]);
        NSLog(@"just for breaking");
        
        Story * story = [self MakeStory:storyDictionary];
        Level * level = [self findLevel:[storyDictionary[@"level"] integerValue]];
        NSMutableArray * storiesForLevel = [self.storiesByLevel objectForKey:level];
        if(!storiesForLevel)
        {
            storiesForLevel = [[NSMutableArray alloc]init];
        }
        [storiesForLevel addObject:story];
        [self.storiesByLevel setObject:storiesForLevel forKey:level];
    }
    
}

-(void) LoadStoriesFromUrl:(NSString*)dataPath
{
    //dummy base class implementations
    //needs to be overridden by the concrete classes
    
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
                NSLog([NSString stringWithFormat:@"Number of stories %lu",(unsigned long)[stories count]]);
                
                NSLog(@"just for breaking");
            }
         
        }
    ];

}
-(NSInteger) GetNumberOfLevels
{
    
    //dummy base class implementations
    //needs to be overridden by the concrete classes
    
    return 0;
}
-(void) Setup
{
    self.storiesByLevel =[[NSMutableDictionary alloc] init];
    
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
