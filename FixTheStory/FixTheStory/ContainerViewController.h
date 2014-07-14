//
//  containerViewController.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 3/25/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FixedStoriesCounter.h"
#import "StoryXMLParser.h"
#import "Story.h"
#import "StoryDispatchService.h"

@interface ContainerViewController : UIViewController 

@property (atomic) StoryXMLParser * storyParser;
@property (atomic) Story * currentStory;
@property (atomic) Level * currentLevel;
@property (atomic) FixedStoriesCounter * fixedStoryCounter;
@property (atomic) StoryDispatchService * storyDispatchService;

- (void) setCurrentSubViewController:(UIViewController*) cvc;
- (void) spewSomething;
- (void) showViewControllerWithName:(NSString*)vctype;

- (Story*) getNextStory;
- (void)  updateLastFixedStoryCounter;

@end
