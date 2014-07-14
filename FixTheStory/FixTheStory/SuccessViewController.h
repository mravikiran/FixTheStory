//
//  SuccessViewController.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 7/13/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccessViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
- (IBAction)onContinue:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *mainButton;
- (IBAction)onMain:(id)sender;

@end
