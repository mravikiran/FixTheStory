//
//  ViewControllerFactory.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 3/26/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContainerViewController.h"

@interface ViewControllerFactory : NSObject

+ (UIViewController*) getViewControllerOfType:(NSString*)vctype initWithParent:(ContainerViewController*)parent;


@end
