//
//  ViewControllerFactory.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 3/26/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "ViewControllerFactory.h"
#import "SettingsViewController.h"
#import "RulesViewController.h"
#import "RootViewController.h"
#import "FixTheStoryBaseViewController.h"

@implementation ViewControllerFactory

+ (UIViewController*) getViewControllerOfType:(NSString*)vctype initWithParent:(ContainerViewController *)parent
{
    FixTheStoryBaseViewController * vc = nil;
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
    if ([vctype  isEqualToString: @"settings"]) {
        vc = [storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController_ID" ];
    }
    else if ([vctype isEqualToString:@"rules"])
    {
        vc = [storyboard instantiateViewControllerWithIdentifier:@"RulesViewController_ID" ];
    }
    else if ([vctype isEqualToString:@"root"])
    {
        vc = [storyboard instantiateViewControllerWithIdentifier:@"RootViewController_ID" ];
    }
    
    vc.parent = parent;
    return vc;
}

@end
