//
//  PlayViewController.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 3/31/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FixTheStoryBaseViewController.h"

@interface PlayViewController : FixTheStoryBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *stageButton;

@property (weak, nonatomic) IBOutlet UIButton *mainButton;

- (IBAction)onStage:(id)sender;

- (IBAction)onMain:(id)sender;

@end
