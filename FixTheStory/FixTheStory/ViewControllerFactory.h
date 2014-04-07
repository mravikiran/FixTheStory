//
//  ViewControllerFactory.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 3/26/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContainerViewController.h"
#import "FixTheStoryBaseViewController.h"

@interface ViewControllerFactory : NSObject

+ (FixTheStoryBaseViewController*) getViewControllerOfType:(NSString*)vctype;

@end
