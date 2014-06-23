//
//  containerViewController.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 3/25/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController <NSXMLParserDelegate>
- (void) setCurrentSubViewController:(UIViewController*) cvc;

- (void) spewSomething;
- (void) showViewControllerWithName:(NSString*)vctype;

@end
