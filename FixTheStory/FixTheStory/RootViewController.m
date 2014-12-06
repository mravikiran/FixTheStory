//
//  ViewController.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 2/28/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "RootViewController.h"
#import "ContainerViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.subContainer.hidden = YES;
    [self.subContainer setOpaque:true];
    self.subContainer.backgroundColor = [UIColor whiteColor];
    
    [self.view bringSubviewToFront:self.subContainer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSettings:(id)sender {
    if ([self parentViewController]) {
    [(ContainerViewController*)[self parentViewController] showViewControllerWithName:@"settings"];
    }
}

- (IBAction)onRules:(id)sender {
    if ([self parentViewController]) {
    [(ContainerViewController*)[self parentViewController] showViewControllerWithName:@"rules"];
    }
}

- (IBAction)onPlay:(id)sender {
    if ([self parentViewController]) {
    [(ContainerViewController*)[self parentViewController] showViewControllerWithName:@"play"];

    }
}
@end
