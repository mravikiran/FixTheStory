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
    self.storiesByLevel =[[NSMutableDictionary alloc] init];
}



- (void)parser:(NSXMLParser *)parser
        didStartElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI
        qualifiedName:(NSString *)qName
        attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"stories"]) {
       // NSLog(@"Found the root element");
    }
    else
    if ([elementName isEqualToString:@"level"]) {
       // NSLog(@"Level started");
        self.currentLevel = [[Level alloc] initWithNumber:[attributeDict[@"number"] integerValue]];
        
    }
    else
        if ([elementName isEqualToString:@"story"]) {
         //   NSLog(@"Story started");
            self.currentStory = [[Story alloc] init];
            self.currentStory.numberOfImages = [attributeDict[@"length"] integerValue];
            self.currentStory.id = [attributeDict[@"id"] integerValue];
        }
        else
            if ([elementName isEqualToString:@"image"]) {
                self.element=nil;
           //     NSLog(@"image started");
                
            }
            else
                if ([elementName isEqualToString:@"actualStory"]) {
                    self.element=nil;
             //       NSLog(@"actual story started");
                    
                }
                else
                {
               //     NSLog(@"%@",elementName);
                }

    
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string{

if(self.element == nil)

self.element = [[NSMutableString
            alloc] init];

[self.element appendString:string];
//    NSLog(@"Found characters %@",self.element);

}

- (void)parser:(NSXMLParser *)parser
        didEndElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI
        qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"level"]) {
  //      NSLog(@"Level end");
        [self.storiesByLevel setObject:self.stories forKey:self.currentLevel];
        self.stories=nil;
        self.stories=[[NSMutableArray alloc] init];
        self.currentLevel=nil;
        
        
        
    }
    else
    if ([elementName isEqualToString:@"story"]) {
    //    NSLog(@"Story end");
    
        [self.stories addObject:self.currentStory];
        self.currentStory=nil;
    }
    else
        if ([elementName isEqualToString:@"image"]) {
      //      NSLog(@"image end");
            self.currentImage=self.element;
            [self.currentStory addPartOfStory:self.currentImage];
            self.element=nil;
            self.currentImage=nil;
    }
    else
    if ([elementName isEqualToString:@"actualStory"]) {
        //NSLog(@"actual story end");
        self.currentStory.actualStory = self.element;
        self.element=nil;
    }

    else{
   //     NSLog(@"%@",elementName);
    }
    
    
}

#pragma baseclass functions
-(void) LoadStoriesFromUrl:(NSString*)dataPath;
{
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    self.xmlParser= [[NSXMLParser alloc] initWithData:data];
    [self setup];
    [self.xmlParser setDelegate:self];
    BOOL result = [self.xmlParser parse];
    if(result){
        NSLog(@"Successfully parsed");
    }
}






@end
