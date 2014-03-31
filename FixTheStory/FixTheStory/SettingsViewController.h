//
//  SettingsViewController.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 3/22/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FixTheStoryBaseViewController.h"

@interface SettingsViewController : FixTheStoryBaseViewController

@property IBOutlet UIButton * mainButton;
@property IBOutlet UIButton * rulesButton;
@property IBOutlet UIButton * playButton;

- (IBAction)onMain:(id)sender;
- (IBAction)onPlay:(id)sender;
- (IBAction)onRules:(id)sender;

@end
