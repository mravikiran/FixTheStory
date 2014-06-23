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
    
    if ([elementName isEqualToString:@"level"]) {
        NSLog(@"Level started");
        
    }
    else
        if ([elementName isEqualToString:@"story"]) {
            NSLog(@"Story started");
            
        }
        else
            if ([elementName isEqualToString:@"image"]) {
                NSLog(@"image started");
            }
            else{
            NSLog(@"%@",elementName);
        }

    
}

- (void)parser:(NSXMLParser *)parser
        didEndElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI
        qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"level"]) {
        NSLog(@"Level end");
        
    }
    else
    if ([elementName isEqualToString:@"story"]) {
        NSLog(@"Story end");
        
    }
    else
        if ([elementName isEqualToString:@"image"]) {
        NSLog(@"image end");
    }
    else{
        NSLog(@"%@",elementName);
    }
    
    
}



@end
