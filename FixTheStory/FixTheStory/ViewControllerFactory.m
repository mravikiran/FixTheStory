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
#import "PlayViewController.h"

@implementation ViewControllerFactory

+ (FixTheStoryBaseViewController*) getViewControllerOfType:(NSString*)vctype
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
    else if ([vctype isEqualToString:@"play"])
    {
        vc = [storyboard instantiateViewControllerWithIdentifier:@"PlayViewController_ID" ];
    }
    else if ([vctype isEqualToString:@"stage"])
    {
        vc = [storyboard instantiateViewControllerWithIdentifier:@"StageViewController_ID" ];
        
    }
    else if([vctype isEqualToString:@"success"])
    {
        vc = [storyboard instantiateViewControllerWithIdentifier:@"SuccessViewController_ID" ];
    }
    
    return vc;
}

@end
