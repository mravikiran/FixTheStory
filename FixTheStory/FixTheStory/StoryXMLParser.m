//
//  StoryXMLParser.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/9/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "StoryXMLParser.h"

@implementation StoryXMLParser



- (void)parser:(NSXMLParser *)parser
        didStartElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI
        qualifiedName:(NSString *)qName
        attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"stories"]) {
        self.storiesbyLevel = [[NSMutableDictionary alloc] init];
    }
    else
    if ([elementName isEqualToString:@"level"]) {
        NSLog(@"Level started");
        self.stories = [[NSMutableArray alloc] init];
        self.currentLevel = [[Level alloc] initWithNumber:[attributeDict[@"number"] integerValue]];
        
        
    }
    else
        if ([elementName isEqualToString:@"story"]) {
            NSLog(@"Story started");
            self.currentStory = [[Story alloc] init];
            self.currentStory.numberOfImages = [attributeDict[@"length"] integerValue];
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
        self.currentLevel=nil;
        self.stories=nil;
        
        
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



@end
