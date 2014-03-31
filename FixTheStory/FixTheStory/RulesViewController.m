//
//  RulesViewController.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 3/22/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "RulesViewController.h"
#import "ContainerViewController.h"

@interface RulesViewController ()

@end

@implementation RulesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onMain:(id)sender {
    if ([self parentViewController]) {
        [(ContainerViewController*)[self parentViewController] showViewControllerWithName:@"root"];
        
    }
}

- (IBAction)onPlay:(id)sender {
}
@end
