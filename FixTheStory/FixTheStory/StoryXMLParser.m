//
//  StoryXMLParser.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/9/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "StoryXMLParser.h"

@implementation StoryXMLParser



-(void) setup{
    self.easyStories = [[NSMutableArray alloc] init];
    self.mediumStories = [[NSMutableArray alloc] init];
    self.stories = [[NSMutableArray alloc] init];
    self.storiesbyLevel =[[NSMutableDictionary alloc] init];
}



- (void)parser:(NSXMLParser *)parser
        didStartElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI
        qualifiedName:(NSString *)qName
        attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"stories"]) {
        NSLog(@"Found the root element");
    }
    else
    if ([elementName isEqualToString:@"level"]) {
        NSLog(@"Level started");
        self.currentLevel = [[Level alloc] initWithNumber:[attributeDict[@"number"] integerValue]];
        
    }
    else
        if ([elementName isEqualToString:@"story"]) {
            NSLog(@"Story started");
            self.currentStory = [[Story alloc] init];
            self.currentStory.numberOfImages = [attributeDict[@"length"] integerValue];
            self.currentStory.id = [attributeDict[@"id"] integerValue];
        }
        else
            if ([elementName isEqualToString:@"image"]) {
                self.element=nil;
                NSLog(@"image started");
                
            }
            else
                if ([elementName isEqualToString:@"actualStory"]) {
                    self.element=nil;
                    NSLog(@"actual story started");
                    
                }
                else
                {
                    NSLog(@"%@",elementName);
                }

    
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string{

if(self.element == nil)

self.element = [[NSMutableString
            alloc] init];

[self.element appendString:string];
    NSLog(@"Found characters %@",self.element);

}

- (void)parser:(NSXMLParser *)parser
        didEndElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI
        qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"level"]) {
        NSLog(@"Level end");
        [self.storiesbyLevel setObject:self.stories forKey:self.currentLevel];
        self.stories=nil;
        self.stories=[[NSMutableArray alloc] init];
        self.currentLevel=nil;
        
        
        
    }
    else
    if ([elementName isEqualToString:@"story"]) {
        NSLog(@"Story end");
    
        [self.stories addObject:self.currentStory];
        self.currentStory=nil;
    }
    else
        if ([elementName isEqualToString:@"image"]) {
            NSLog(@"image end");
            self.currentImage=self.element;
            [self.currentStory addPartOfStory:self.currentImage];
            self.element=nil;
            self.currentImage=nil;
    }
    else
    if ([elementName isEqualToString:@"actualStory"]) {
        NSLog(@"actual story end");
        self.currentStory.actualStory = self.element;
        self.element=nil;
    }

    else{
        NSLog(@"%@",elementName);
    }
    
    
}

-(Story*) getStoryNumber:(NSInteger)storyNum fromLevel:(NSInteger)levelNum
{
    NSArray * stories;
    for(Level *key in self.storiesbyLevel)
    {
        if (key.number == levelNum) {
            
            stories = self.storiesbyLevel[key];
            break;
        }
    }
    if ([stories count] < storyNum) {
        storyNum = [stories count];
    }
    return stories[storyNum-1]; // presently its not returning any null value
    
}

-(NSArray*) getStoriesFromLevel:(NSInteger)level { // change the interface to the object Level
    
    for (Level * key  in self.storiesbyLevel) {
        if (key.number == level) {
            return self.storiesbyLevel[key];
        }
    }
    return nil;
}

-(NSInteger) getNumberOfLevels {
    return [self.storiesbyLevel count];
}



@end
