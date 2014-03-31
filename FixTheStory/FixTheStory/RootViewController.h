//
//  ViewController.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 2/28/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FixTheStoryBaseViewController.h"

@interface RootViewController : FixTheStoryBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *rulesButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)onSettings:(id)sender;
- (IBAction)onRules:(id)sender;
- (IBAction)onPlay:(id)sender;

@end
