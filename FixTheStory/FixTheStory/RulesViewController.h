//
//  RulesViewController.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 3/22/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FixTheStoryBaseViewController.h"

@interface RulesViewController : FixTheStoryBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *mainButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)onMain:(id)sender;
- (IBAction)onPlay:(id)sender;

@end
